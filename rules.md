# Mal3abk Project Rules

> **MANDATORY FOR ALL AI AGENTS (Claude, Cursor, Copilot, Codex, Gemini, or any other assistant):**
> You **MUST** read this entire file before making any change to the repository.
> You **MUST NOT** skip, ignore, soften, reinterpret, or work around any rule in this file.
> If a rule conflicts with a user request, **stop and ask** — do not silently violate the rule.
> If a rule is unclear, **ask for clarification** — do not guess.
> If you find code in the repo that violates a rule, **point it out** but do not refactor it unless the user explicitly asks.

---

## 1. Tech Stack (Fixed — Do Not Replace)

- **State management:** `flutter_bloc` (Cubit/Bloc) with `freezed` states.
- **Networking:** `dio` + `retrofit` API services; responses mapped through `ApiResult<T>`.
- **Dependency injection:** `get_it`, configured in `lib/core/di/service_locator.dart`.
- **Models & unions:** `freezed` + `json_serializable` (generated `.freezed.dart` / `.g.dart` files).
- **Localization:** `easy_localization` with strings in `assets/translations/{ar,en}.json`.
- **Sizing:** `flutter_screenutil_plus` for responsive dimensions.
- **Storage:** `shared_preferences` for non-sensitive data; `flutter_secure_storage` for tokens and secrets.
- **Routing:** `Navigator 1.0` with `onGenerateRoute` and route name constants.

**Rule:** Do not introduce a new package that overlaps an existing one (e.g., do not add `go_router`, `provider`, `riverpod`, `chopper`, `injectable`, etc.) without explicit approval.

**After touching any `freezed`, `json_serializable`, or `retrofit` file, you MUST run:**

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 2. Core Principles

1. Make the **smallest** change that solves the problem.
2. Fix **root causes**, not symptoms.
3. Do **not** refactor unrelated code unless explicitly requested.
4. Do **not** add new abstractions or dependencies without a clear, stated reason.
5. Prefer **clarity over cleverness**.
6. Code must be **simple, readable, maintainable, reusable, and scalable** — in that order.
7. Never break existing functionality, APIs, flows, or UX unless explicitly instructed.
8. Read relevant code before modifying it — state assumptions when unclear.

---

## 3. Architecture

Strict layering: **presentation → domain → data**. Arrows only point downward. A lower layer never imports an upper layer.

```
presentation/  → uses → domain/
domain/        → defines contracts (abstract repos + use cases only)
data/          → implements domain contracts, talks to API/storage
```

- **UI/presentation:** renders state, dispatches actions. No business logic.
- **Domain:** abstract repository contracts, use cases. No Flutter imports — pure Dart. **No entities.**
- **Data:** API services, DTOs/models, repository implementations.
- In UI files, do not create private helper widgets or private helper methods for action flows. Keep the action code in the place where it is used, or extract a separate named widget/file if it truly needs reuse.

### No Entities — Only DTOs / Models

We do **not** use domain entities or entity mapping. Models and DTOs defined in the data layer are used directly throughout the app. Never create `*_entity.dart` files or map models to entities.

```dart
// ❌ WRONG — do not do this
class UserEntity { ... }                        // entity in domain
UserModel toEntity() => UserEntity(...);        // mapping step

// ✅ CORRECT — use the model directly
class UserModel { ... }                         // model in data layer
// Cubit receives UserModel directly from repo
```

### Repository Contract and Implementation

The abstract repository contract lives in the **domain layer**. The concrete implementation lives in the **data layer**. They must always come in pairs.

```
domain/
  repos/
    auth_repo.dart          ← abstract contract (interface)

data/
  repos/
    auth_repo_impl.dart     ← concrete implementation
```

- The abstract repo in domain defines **only method signatures** — no implementation, no imports from data.
- The impl in data implements the abstract contract, calls the API service, maps exceptions to `AppApiFailure`, and returns `ApiResult<T>` with the model directly.
- **Never** put a repo implementation in the domain layer.
- **Never** skip the abstract contract — every repo impl must implement its matching domain contract.
- All constructors use **named parameters** (`{required this.field}`). Never use positional parameters for classes.
- All injected fields are **public** (no leading underscore). Use `this.api`, `this.authRepo`, `this.loginUseCase` — not `this._api`, `this._authRepo`.

```dart
// domain/repos/auth_repo.dart
abstract class AuthRepo {
  Future<ApiResult<UserModel>> login(LoginRequestBody body);
}

// data/repos/auth_repo_impl.dart
class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required this.api});
  final AuthApiService api;

  @override
  Future<ApiResult<UserModel>> login(LoginRequestBody body) async {
    try {
      final model = await api.login(body);
      return ApiResult.success(model);
    } catch (e, st) {
      return ApiResult.failure(ApiFailureMapper.map(e, st));
    }
  }
}
```

### When to use a UseCase

**Simple flow (Cubit calls repo directly):**
```
UI → Cubit → Repository
```
Use this when the cubit makes one repository call and emits state.

**Complex flow — MUST use a UseCase:**
```
UI → Cubit → UseCase → Repository(ies)
```

**You MUST move logic to a UseCase when any of the following is true:**
- The logic is too big to sit cleanly in the Cubit method.
- The flow is multi-step (e.g., login then fetch profile then store token).
- It combines calls to multiple repositories.
- It contains real business rules or decisions.
- It is reused across multiple Cubits.
- It involves validation, transformation, or orchestration that is not purely UI.

**Rule:** If you catch yourself writing business logic inside a Cubit method or — worse — inside the presentation layer, **stop**. Move that logic to a UseCase in the domain layer. The Cubit's only job is: call the use case → receive `ApiResult<T>` → emit state.

```dart
// domain/use_cases/login_use_case.dart
class LoginUseCase {
  LoginUseCase({required this.authRepo});
  final AuthRepo authRepo;

  Future<ApiResult<UserModel>> call(LoginRequestBody body) async {
    // All business logic lives here, not in the cubit
    final result = await authRepo.login(body);
    return result.when(
      success: (user) {
        // e.g., validate role, check status, etc.
        return ApiResult.success(user);
      },
      failure: ApiResult.failure,
    );
  }
}

// presentation/cubit/login_cubit.dart
class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCase}) : super(const LoginState.initial());
  final LoginUseCase loginUseCase;

  // Cubit is thin — call use case, emit state. Nothing more.
  Future<void> login(LoginRequestBody body) async {
    emit(const LoginState.loading());
    final result = await loginUseCase(body);
    result.when(
      success: (user) => emit(LoginState.success(user)),
      failure: (f) => emit(LoginState.error(f.userMessage)),
    );
  }
}
```

---

## 4. Project Structure

Organize by **feature first**, then by layer:

```
lib/
  core/
    app/
    config/
    di/
    extensions/
    local_storage/
    network/
    routes/
    styles/
    theme/
    utils/
    widgets/        ← shared widgets used in 2+ features
  features/
    login/
      data/
        apis/
        models/        ← DTOs/models used directly (no entity mapping)
        repos/         ← repo implementations
      domain/
        repos/         ← abstract repo contracts only
        use_cases/     ← business logic lives here
      presentation/
        cubit/
        screens/
        widgets/
```

**Rule:** Before creating a new helper, constant, color, text style, or widget, **search `core/` first**. If something similar exists, use it. Do not duplicate.

---

## 5. Routing

Use `Navigator 1.0` with a centralized `onGenerateRoute` and string constants. **Do not** use anonymous routes, inline `MaterialPageRoute(builder: ...)` calls inside widgets, or push `Widget` instances directly.

### Rules

1. Every route name lives in `AppRoutes` as a `static const String`.
2. All route construction happens in **one** `onGenerateRoute` switch.
3. If the screen needs a Cubit/Bloc, wrap it in `BlocProvider` **inside** `onGenerateRoute`, created via `sl<>()`.
4. Always pass `settings: RouteSettings(name: AppRoutes.x)` so analytics and `Navigator.popUntil` work.
5. Arguments are passed via `settings.arguments` and **cast safely** with a clear failure path.
6. Navigate using `Navigator.pushNamed(context, AppRoutes.x)` — never hardcode strings at call sites.
7. All app routing must stay centralized in `lib/core/routes/`. Do not create feature-local route builders.
8. Do not provide Bloc/Cubit instances in screens or feature widgets. Always use `sl<>()` in `app_router.dart`.

### Example

```dart
// core/routes/routes.dart
class AppRoutes {
  AppRoutes._();
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
}

// core/routes/app_router.dart
class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          settings: const RouteSettings(name: AppRoutes.login),
          builder: (_) => BlocProvider<LoginCubit>(
            create: (_) => sl<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      default:
        return _errorRoute('Unknown route: ${settings.name}');
    }
  }

  static Route _errorRoute(String message) => MaterialPageRoute(
        builder: (_) => Scaffold(body: Center(child: Text(message))),
      );
}
```

---

## 6. UI Rules

The UI may **only**:
- render state,
- send user actions to a Cubit/Bloc,
- react to state changes,
- handle local UI-only concerns (focus, scroll, animations).

The UI **must not**:
- call repositories or APIs directly,
- contain business rules,
- do heavy filtering/sorting/processing,
- own large decision flows.

### Other UI rules

- `setState` is only for **local, UI-only** state inside small leaf widgets (toggles, focus, hover).
- **Do not** create private widget helper functions (`Widget _buildHeader()`) — extract into a separate named widget class in its own file.
- **Do not** create private widget classes (`_MyWidget`). All widgets are named public classes.
- **Do not** create widgets as functions that return `Widget`.
- Place `BlocBuilder` / `BlocListener` / `BlocConsumer` / `BlocSelector` on the **smallest** subtree that needs to rebuild.
- Every `BlocBuilder`, `BlocListener`, `BlocConsumer`, or `BlocSelector` must live in its own named widget file. Name the file after the widget and suffix the Bloc role: `login_bloc_listener.dart`.
- Use `flutter_screenutil_plus` for sizes: `16.w`, `24.h`, `12.r`, `14.sp`. Avoid raw pixel literals.
- Do not put form submission, save, validation, or branching functions in screens. Screens compose widgets only.
- Spacing: do not use `SizedBox` directly. Use `hSpace(height)` and `vSpace(width)` from `lib/core/app/app_spaces.dart`.

---

## 7. Cubit and State Rules

- Use **Cubit by default**, **Bloc** when you have many discrete events or need event transformers.
- Cubits depend on **UseCases** when business logic exists, otherwise on **repositories** directly.
- Cubits **never** depend on data sources, Dio, or API services directly.
- Cubits must consume `ApiResult<T>` with `result.when(success: ..., failure: ...)`.
- State is **always** a `freezed` union covering: `initial`, `loading`, `success`, `error` (add more cases only when needed).
- Never hand-write `copyWith`, `==`, or `hashCode` for state classes.
- One cubit per screen/feature concern. Do not build "god cubits".
- Cubits must not import Flutter widgets (`material.dart`). `flutter/foundation.dart` is fine.

### Exhaustive State Matching and Destructuring (Dart 3 Switch Expression)

Instead of using `if (state is MyState)` conditionals inside `BlocBuilder`s or Cubits, you **MUST** use Dart 3's switch expressions / pattern matching with object destructuring.

```dart
return switch (state) {
  SplashLoading() => const LoadingWidget(),
  SplashSuccess(:final data) => ContentWidget(data: data),
  SplashError(:final message) => ErrorWidget(message),
  _ => const SizedBox.shrink(),
};
```

---

## 8. Flutter and Widget Discipline

- Use `const` constructors **wherever possible**.
- **Never** create `TextEditingController`, `AnimationController`, `FocusNode`, `ScrollController`, or `StreamSubscription` inside `build()`. Create them in `initState` or inject them.
- **Always** dispose controllers, focus nodes, animation controllers, and stream subscriptions in `dispose()` / `close()`.
- No heavy synchronous work inside `build()` — no sorting, parsing, or filtering large lists.
- **Must** use small composed widgets. If a widget's `build` exceeds ~80 lines, you **must** split it — no exceptions.
- One named widget per file. File name: `*_widget.dart`.

---

## 9. Domain and Data Rules

- Domain layer: **no Flutter imports**, ever. Pure Dart. Contains only abstract repo contracts and use cases.
- Data layer: **catches** exceptions and maps them to `AppApiFailure` via `lib/core/network/api_failure_mapper.dart`. Exceptions never leak past the repository.
- Repositories and UseCases **always** return `ApiResult<T>` — the `freezed` union of `Success<T>` and `ApiFailure`.
- Do **not** invent ad-hoc result types.
- **No entities.** Use DTOs / models (`*_model.dart`) from the data layer directly. Do not create `*_entity.dart` files and do not add `toEntity()` mapping methods.
- Do not create models in the presentation layer. If a screen needs structured input data, put it in the data layer as a request body (`*_request_body.dart`) or model.
- Every feature `data/apis/` folder must contain Retrofit service files named `{feature}_api_service.dart`.
- Repository contracts and implementations are both required:
  - `domain/repos/{feature}_repo.dart` — abstract contract (interface), no implementation
  - `data/repos/{feature}_repo_impl.dart` — concrete implementation that calls API + maps exceptions
- Never `print`, `throw`, or `rethrow` silently. Map and return.

---

## 10. Dependency Injection

- All registration lives in `lib/core/di/service_locator.dart`.
- Order: external clients → data sources → repositories → use cases → cubits.
- **Cubits:** `registerFactory` (new instance per route).
- **UseCases:** `registerLazySingleton`.
- **Repos / Services / Dio:** `registerLazySingleton`.
- **Never** call `MyCubit(MyRepo(MyApi()))` by hand in widgets or routes. Always `sl<MyCubit>()`.

### Constructor and Field Rules (apply to every injectable class — Cubit, UseCase, Repo, Service)

- **Always use named parameters.** Every injectable class must use `{required this.field}` — never positional parameters.
- **All injected fields are public.** No leading underscore on any dependency field. `final AuthRepo authRepo` ✅ — `final AuthRepo _authRepo` ❌.
- This applies to: Cubits, UseCases, repo implementations, API services, and any class registered in `get_it`.

---

## 11. Design System

Centralized under `lib/core/styles/`:

- Colors → `app_colors.dart`
- Text styles → `app_text_styles.dart`
- Font families → `app_font_family.dart`
- Asset paths → `app_assets.dart`
- Theme assembled in `lib/core/theme/app_theme.dart`

**Rules:**
- **Never** write `Color(0xFF...)` or `TextStyle(...)` inside a feature widget. Pull from `AppColors` / `AppTextStyles`.
- **Never** write asset paths as raw strings (`'assets/icons/x.svg'`). Use `AppAssets.x`.
- If a needed color/style/asset doesn't exist, **add it to the central file**, don't inline it.

---

## 12. Localization (Arabic + English, RTL-aware)

- **Never** hardcode user-facing strings. Always `'key'.tr()`.
- Key naming: `feature.screen.element` (e.g., `login.form.emailHint`). Keep keys in sync between `ar.json` and `en.json`.
- For directional layouts, use `EdgeInsetsDirectional`, `AlignmentDirectional`, and `start`/`end` instead of `left`/`right`.
- Icons that imply direction (arrows, chevrons) must mirror in RTL.
- Numbers, dates, and currency formatted via `intl` with the current locale.
- Failure messages: repos/use cases return **localization keys** or messages mapped through `AppApiFailure`. UI translates on display.

---

## 13. Forms and Validation

- Validation **rules** live in the domain layer (pure functions or value objects).
- Validation **triggering** happens in the Cubit, not the widget.
- Use `Form` + `GlobalKey<FormState>` for synchronous field validation UI; the cubit owns submission-time validation.
- Show errors via state, not via `setState`.
- Never use Flutter's raw `TextFormField` in app or feature code. Use `CustomTextFormField` from `lib/core/widgets/custom_text_form_field.dart`.
- **Never disable the submit button to block invalid input.**
- Use `CustomButton` from `lib/core/widgets/custom_button.dart` for all buttons.

---

## 14. Error Handling and User Messages

- `AppApiFailure` is the **only** failure type that reaches the cubit.
- A single mapper turns exceptions into `AppApiFailure`.
- Cubit emits the failure/message in its error state. UI calls `.tr()` at display time.
- Never show raw exception text (`e.toString()`) to the user.
- Handle null, empty, loading, and error states explicitly — no silent failures.

---

## 15. Performance

- Use `const` widgets everywhere possible to prevent unnecessary rebuilds.
- Place `BlocBuilder`/`BlocSelector` on the **smallest** widget subtree that needs to rebuild — never at the top of the tree.
- Never create expensive objects inside `build()`.
- No heavy synchronous work inside `build()`.
- Use `cached_network_image` for network images.
- Dispose all streams, controllers, and subscriptions in `dispose()` / `close()`.
- Use `flutter_screenutil_plus` for responsive sizing.

---

## 16. Logging

- Use **one** logger wrapper (`lib/core/utils/app_logger.dart`). Do not call `print` or `debugPrint`.
- Log levels: `d`, `i`, `w`, `e`.
- **Never** log: tokens, passwords, full Authorization headers, OTPs, PII.

---

## 17. Security

- **Never** hardcode API keys, tokens, secrets, or credentials anywhere in code.
- Use `flutter_secure_storage` for tokens at runtime. Use `shared_preferences` only for non-sensitive preferences/flags.
- `.env` files in `.gitignore`. Use `.env.example` as a template.

---

## 18. Environments and Configuration

- Base URLs and config live in `lib/core/config/env_config.dart` or `app_config.dart`.
- Multiple entry points: `main_dev.dart`, `main_prod.dart`, `main_common.dart`, `main.dart`.

```bash
flutter run --dart-define=BASE_URL=https://api.dev.mal3abk.app --dart-define=ENV=dev
```

---

## 19. Testing

- Use `flutter_test`, `bloc_test`, and `mocktail`.
- Test folder mirrors `lib/` structure.
- Cover **at minimum**: every UseCase, every repo implementation's mapping logic, every Cubit's state transitions.
- One main behavior per test. Use `group()` per class/method.

---

## 20. Naming and File Quality

- File-name conventions (strict):

| Type | Pattern | Example | Layer |
|---|---|---|---|
| Widget | `*_widget.dart` | `custom_button.dart` / `login_form_widget.dart` | presentation |
| Screen | `*_screen.dart` | `login_screen.dart` | presentation |
| Cubit | `*_cubit.dart` | `login_cubit.dart` | presentation |
| State | `*_state.dart` | `login_state.dart` | presentation |
| Abstract repo | `*_repo.dart` | `auth_repo.dart` | **domain** |
| UseCase | `*_use_case.dart` | `login_use_case.dart` | **domain** |
| Repo impl | `*_repo_impl.dart` | `auth_repo_impl.dart` | data |
| Retrofit service | `*_api_service.dart` | `auth_api_service.dart` | data |
| Model / DTO | `*_model.dart` | `user_model.dart` | data |
| Request body | `*_request_body.dart` | `login_request_body.dart` | data |

**Note:** There are NO `*_entity.dart` files in this project. Models are used directly.

- One named widget/class per file.
- **Never** edit generated files (`*.g.dart`, `*.freezed.dart`) by hand.

---

## 21. Linting

- The project uses `analysis_options.yaml` with strict rules. Do not weaken it.
- Required: `prefer_const_constructors`, `prefer_const_literals_to_create_immutables`, `avoid_print`, `use_super_parameters`.
- Direct `TextFormField` usage is forbidden outside `lib/core/widgets/custom_text_form_field.dart`.
- Direct `ElevatedButton`, `FilledButton`, `OutlinedButton`, `TextButton` usage is forbidden outside `lib/core/widgets/custom_button.dart`.
- Direct `SizedBox` usage is forbidden outside `lib/core/app/app_spaces.dart`. Use `hSpace(height)` and `vSpace(width)`.
- Code must pass `dart analyze` with **zero** warnings before committing.

---

## 22. GitHub Workflow

- **Always ask for confirmation** before any action visible to others (creating/merging PRs, posting comments, pushing branches).
- **Never force-push** to main/master or shared branches.
- **Never skip hooks** (`--no-verify`) unless explicitly requested.

---

## 23. Commit Message Rule

When the user says **`done`** after a completed change request:
- Respond **only** with a conventional commit message.
- Format:
  ```
  type(scope): short summary

  - bullet describing change
  - bullet describing change
  ```
- Valid `type`: `feat`, `fix`, `refactor`, `perf`, `style`, `docs`, `test`, `chore`, `build`, `ci`.

---

## 24. Final Reminder to AI Agents

- Do **not** skip rules to be "more helpful".
- Do **not** invent new patterns when an existing one in this file applies.
- Do **not** silently change unrelated files.
- Do **not** weaken `freezed`, `ApiResult`, or DI conventions for convenience.
- When in doubt: **ask**.
