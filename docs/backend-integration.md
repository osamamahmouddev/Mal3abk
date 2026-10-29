# Backend Integration (Phase 0 / Phase 1)

How the player app talks to the Malabak API, and what is still waiting on the backend.

## Running against the local API

The API (`dotnet run` in `mal3abk-backend`) listens on port 5000, with Swagger at `/swagger`. In Development, OTP codes and recovery links are posted to the private Slack channel `#malabak-otp`.

```bash
flutter run -t lib/main_dev.dart
```

| Target | Base URL used by `DevEnvConfig` |
|---|---|
| Android emulator | `http://10.0.2.2:5000` |
| iOS simulator / desktop | `http://127.0.0.1:5000` |
| Physical device or staging | `--dart-define=BASE_URL=http://<host-lan-ip>:5000` |

Plain HTTP is allowed only in the Android **debug** manifest. Release builds stay HTTPS-only.

The web build cannot call the local API, because the API's CORS policy only allows the web dashboard origins. Mobile builds are not affected.

## Client foundation (`lib/core/network`, `lib/core/local_storage`)

- **`DioFactory`**: JSON, 30 s connect/send/receive timeouts, and `RequestHeadersInterceptor`, which sends `X-Locale`, `Accept-Language` (`ar` / `en`) and `X-Device-Id`.
- **`ApiLoggingInterceptor`**: debug builds only. It logs method, path, status and duration. Headers, query strings and bodies are never logged, so tokens, OTP codes and phone numbers never reach the logs. `pretty_dio_logger` was removed because it logged all of them.
- **`AuthInterceptor`**: attaches the access token, except on anonymous endpoints (`ApiConstants.anonymousPaths`).
  - On a 401 it calls `POST /auth/refresh` once and replays the request. Concurrent 401s share one refresh call.
  - The refresh runs on a separate Dio that has no `AuthInterceptor`.
  - A rejected refresh token (400/401) clears the session and opens login through `AppNavigator.openLogin`. Offline errors or 5xx keep the session.
- **`ApiFailureMapper`**: maps RFC 9457 ProblemDetails to `AppApiFailure`.
  - The machine code is read from `errorCode`, then `code` (validation), then `title` (identity errors such as `Identity.InvalidOtpCode`).
  - `message` is always a localization key. The UI translates it with `.tr()`.
- **`AuthTokenStorage`**: access and refresh tokens in `flutter_secure_storage`, with an in-memory copy.
- **`DeviceIdStorage`**: a per-install UUID v4 in `shared_preferences`. It is not a secret and is reset on reinstall.
  - The API on `dev` ignores it. The upcoming device-sessions work (`back_end_phase_01`) reads the `X-Device-Id` header.
  - `deviceId` is **not** sent in request bodies, because the API does not accept it there.

## Endpoints wired

| Endpoint | Where |
|---|---|
| `POST /api/v1/auth/otp/send` | Login, phone step (`SendOtpCubit`) |
| `POST /api/v1/auth/otp/verify` | Login, code step (`VerifyOtpCubit`). New users go to profile setup; returning users go to the main shell. |
| `POST /api/v1/auth/refresh` | `AuthInterceptor` |
| `POST /api/v1/auth/logout` | Settings → Account → Log out |
| `POST /api/v1/auth/logout-all` | Settings → Account → Log out of all devices (asks for confirmation) |
| `POST /api/v1/me/step-up` | Phone change, step 1 (scope `change_phone`) |
| `POST /api/v1/me/phone-change/start` | Phone change, step 1 |
| `POST /api/v1/me/phone-change/verify-old` | Phone change, step 2 |
| `POST /api/v1/me/phone-change/verify-new` | Phone change, step 3. The API revokes every session, so the app clears its session and opens login. |
| `POST /api/v1/me/phone-change/recover` | `RecoverPhoneScreen`, opened from `https://malabak.app/recover-phone?token=…` |

All of these were exercised against the local API, including error paths: wrong code, a reused recovery link, the rate limit, and a revoked refresh token.

## Integration points still open

- **Turnstile on mobile**: `TurnstileTokenProvider` is the single place to change.
  - Turnstile has no native SDK, so production needs a WebView challenge that returns the token.
  - Until then, dev sends `EnvConfig.turnstileToken` (any non-empty value passes in Development; override with `--dart-define=TURNSTILE_TOKEN=…`).
  - Production sends an empty token, so OTP send fails with `Identity.InvalidTurnstileToken`.
- **Recovery deep link verification**:
  - Android has an `autoVerify` intent filter for `https://malabak.app/recover-phone`. It needs `/.well-known/assetlinks.json` on `malabak.app`.
  - iOS needs the Associated Domains capability (`applinks:malabak.app`) added in Xcode with the team's signing, plus `apple-app-site-association` on the domain.
  - Flutter's built-in deep linking delivers the link to `AppRouter`; no extra package is used.

## Waiting on Phase 2 (keep current mock data)

The `/api/v1/venue-manager/*` endpoints are for venue owners (web dashboard) and must not be used by the player app. These screens stay on their current data until the player endpoints exist:

- **Explore**: list, map, filters and sort, favorites (`features/explore`).
- **Venue profile and pitch/time selection**: venue details, pitches, available slots (`features/explore`).
- **Booking flow**: booking review, deposit instructions, upload proof, proof rejected, my bookings, booking details, cancel booking (`features/booking`).
- **Home**: nearby pitches, upcoming booking (`features/home`).
- **Player profile**:
  - There is no `GET /me` or profile update endpoint yet, so `MyProfileScreen` and `ProfileSetupScreen` stay local.
  - The only way to send a name today is `fullName` on `otp/verify`.
- **Teams, matches and notifications**: no endpoints yet.

`ApiConstants.fields`, `fieldDetails`, `bookings` and `bookingDetails` are old placeholders that do not match the API. Replace them when the Phase 2 contract lands.
