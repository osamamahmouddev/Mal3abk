# ⚽ Mal3abk Mobile Application

> A sports field booking and management mobile application built with **Flutter** following strict software engineering principles and best practices (**Feature-First Clean Architecture**).

---

## 📋 Overview

**Mal3abk** is designed to streamline sports field reservations and management for both players and facility owners. The app provides a modern, responsive, and intuitive user experience with full bilingual support (Arabic & English) and seamless RTL/LTR adaptation.

---

## 🛠 Tech Stack

* **State Management:** `flutter_bloc` (Cubit) with `freezed` union states, evaluated exhaustively using Dart 3 pattern matching and switch expressions.
* **Networking & API:** `dio` + `retrofit` typed REST services, mapped through a unified `ApiResult<T>` and `AppApiFailure` contract.
* **Dependency Injection:** `get_it` service locator configured centrally in `lib/core/di/service_locator.dart` (enforcing named constructor parameters and public fields).
* **Models & Serialization:** `freezed` + `json_serializable` for code-generated immutable DTOs (`.freezed.dart` / `.g.dart`).
* **Localization:** `easy_localization` supporting Arabic (RTL) and English (LTR) with translations located in `assets/translations/`.
* **Responsive Sizing:** `flutter_screenutil_plus` for scalable dimensions (`.w`, `.h`, `.r`, `.sp`) with custom responsive spacing helpers (`hSpace` and `vSpace`).
* **Local Storage:** `flutter_secure_storage` for sensitive tokens/credentials and `shared_preferences` for non-sensitive user settings.
* **Navigation:** Centralized `Navigator 1.0` using `onGenerateRoute` with type-safe arguments and route name constants.

---

## 🏗 Architectural Principles

The application strictly implements **Feature-First Clean Architecture** with downward-only unidirectional dependencies:

```
presentation  ──►  domain  ──►  data
```

### 1. Presentation Layer (`presentation`)
* Renders state and forwards user intents to Cubits.
* Purely reactive — contains no business logic, data persistence, or direct API communication.
* Every UI component is modularized into dedicated files (`*_widget.dart` / `*_screen.dart`).

### 2. Domain Layer (`domain`)
* Pure Dart layer with zero Flutter framework dependencies.
* Defines abstract repository contracts (`*_repo.dart`) and business logic use cases (`*_use_case.dart`).
* **Strict Rule:** No domain entities or redundant entity mappers. Data layer DTO models are consumed directly.

### 3. Data Layer (`data`)
* Implements repository contracts and interacts with network APIs and local storage.
* Houses Retrofit clients (`*_api_service.dart`), request bodies (`*_request_body.dart`), and data models (`*_model.dart`).
* Traps all low-level exceptions and normalizes them into structured `AppApiFailure` instances.

---

## 📂 Project Directory Structure

```
lib/
├── core/                           # Shared foundation and infrastructure
│   ├── app/                        # App config, spacing helpers (hSpace/vSpace), regex, locale
│   ├── config/                     # Environment configuration (Dev / Prod EnvConfig)
│   ├── di/                         # GetIt service locator setup
│   ├── extensions/                 # Context and display helper extensions
│   ├── local_storage/              # Secure token and shared preferences management
│   ├── network/                    # DioFactory, ApiResult, AppApiFailure, ApiFailureMapper
│   ├── routes/                     # AppRoutes, AppRouter, and NavigationLoggerObserver
│   ├── styles/                     # AppColors, AppTextStyles, AppFontFamily, AppAssets
│   ├── theme/                      # Unified light theme definition
│   ├── utils/                      # AppLogger and SafeEmitCubitMixin
│   ├── widgets/                    # Core reusable widgets (CustomButton, CustomTextFormField, etc.)
│   └── core.dart                   # Unified core barrel export
│
├── features/                       # Modular business features
│   ├── splash/                     # Splash screen and authentication state verification
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── auth/                       # Authentication feature (Login flow)
│   │   ├── data/
│   │   │   ├── apis/               # Retrofit AuthApiService
│   │   │   ├── models/             # UserModel, LoginRequestBody
│   │   │   └── repos/              # AuthRepoImpl
│   │   ├── domain/
│   │   │   ├── repos/              # AuthRepo (abstract contract)
│   │   │   └── use_cases/          # LoginUseCase
│   │   └── presentation/
│   │       ├── cubit/              # LoginCubit & LoginState (Freezed)
│   │       ├── screens/            # LoginScreen
│   │       └── widgets/            # LoginFormWidget, LoginBlocListener
│   └── home/                       # Home screen & field booking overview
│
├── assets/
│   ├── Fonts/                      # IBMPlexSansArabic and Fustat font assets
│   ├── images/                     # App logos and vector assets (PNGs / SVGs)
│   └── translations/               # Localization dictionaries (ar.json, en.json)
│
├── mal3abk_app.dart                # MaterialApp configuration with ScreenUtil
├── main_common.dart                # Common bootstrap logic
├── main_dev.dart                   # Development flavor entry point
├── main_prod.dart                  # Production flavor entry point
└── main.dart                       # Default entry point
```

---

## 🚀 Getting Started

### 1. Prerequisites
* **Flutter SDK:** `^3.10.4` or later
* **Dart SDK:** `^3.10.4` or later

### 2. Dependency Installation
```bash
flutter pub get
```

### 3. Code Generation
Run `build_runner` after modifying any `freezed`, `json_serializable`, or `retrofit` definitions:
```bash
dart run build_runner build --delete-conflicting-outputs --force-jit
```

### 4. Running the Application
* **Development Environment:**
  ```bash
  flutter run -t lib/main_dev.dart
  ```
* **Production Environment:**
  ```bash
  flutter run -t lib/main_prod.dart
  ```

---

## 🧪 Testing and Code Quality

### Code Analysis & Linting
The codebase is validated against strict lint rules defined in `analysis_options.yaml`:
```bash
dart analyze
```
> Must maintain **0 errors** and **0 warnings**.

### Unit & Cubit Tests
Execute the automated test suite:
```bash
flutter test
```

---

## 📜 Development Guidelines

For in-depth coding standards, architectural constraints, and repository conventions, please consult [`rules.md`](file:///home/osama/Desktop/Mal3abk/rules.md) in the project root.
