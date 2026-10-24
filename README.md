# ⚽ Mal3abk | تطبيق مَلعَبك

> تطبيق لإدارة وحجز الملاعب الرياضية، مبني باستخدام **Flutter** وفق أعلى معايير هندسة البرمجيات وأفضل الممارسات (**Clean Architecture - Feature-First Layering**).

---

## 📋 نظرة عامة (Overview)

تطبيق **ملعبك** يهدف إلى تسهيل عملية حجز الملاعب الرياضية وإدارتها للمستخدمين وأصحاب الملاعب، مع توفير تجربة مستخدم سلسة وعصرية تدعم اللغتين العربية والإنجليزية وتراعي اتجاهات الواجهة (RTL / LTR).

---

## 🛠 التقنيات المستخدمة (Tech Stack)

* **إدارة الحالة (State Management):** `flutter_bloc` (Cubit) مع `freezed` لتمثيل الحالات بأسلوب Union States ومطابقتها عبر Dart 3 Pattern Matching.
* **الشبكة والاتصال (Networking):** `dio` + `retrofit` لإنشاء خدمات API متكاملة مع معالجة الأخطاء عبر `ApiResult<T>` و `AppApiFailure`.
* **حقن الاعتماديات (Dependency Injection):** `get_it` مع تسجيل مركزي في `lib/core/di/service_locator.dart`.
* **توليد الأكواد والموديلز (Models & Code Gen):** `freezed` + `json_serializable` (توليد ملفات `.freezed.dart` و `.g.dart`).
* **التوطين واللغات (Localization):** `easy_localization` بدعم كامل للغتين العربية والإنجليزية مع ملفات الترجمة في `assets/translations/`.
* **التجاوب والأبعاد (Responsive Sizing):** `flutter_screenutil_plus` لضبط القياسات عبر `.w`, `.h`, `.r`, `.sp` مع دوال التباعد `hSpace` و `vSpace`.
* **التخزين المحلي (Storage):** `flutter_secure_storage` للبيانات الحساسة والتوكنز، و `shared_preferences` للإعدادات العامة.
* **التنقل والتوجيه (Navigation):** `Navigator 1.0` مركزي مع `onGenerateRoute` وتمرير معطيات آمن (Type-Safe Arguments).

---

## 🏗 معمارية المشروع (Architecture)

يعتمد المشروع هيكل **Feature-First Clean Architecture** بطبقات أحادية الاتجاه:

```
presentation  ──►  domain  ──►  data
```

### 1. طبقة العرض (`presentation`)
* مسؤولة فقط عن رسم الواجهات وتمرير أحداث المستخدم للـ Cubit.
* خالية تماماً من منطق الأعمال (Business Logic) أو الاستدعاءات المباشرة للـ API.
* كل مكون يتم استخراجه في ملف مستقل (`*_widget.dart` / `*_screen.dart`).

### 2. طبقة النطاق (`domain`)
* خالية من أي استيراد لـ Flutter (Pure Dart).
* تحتوي فقط على عقود المستودعات (`*_repo.dart`) وحالات الاستخدام (`*_use_case.dart`).
* **قاعدة صارمة:** لا توجد Domain Entities، بل يتم استخدام الـ Models من طبقة البيانات مباشرة.

### 3. طبقة البيانات (`data`)
* مسؤولة عن الاتصال بالـ API وقواعد البيانات المحلية.
* تتضمن: خدمات Retrofit (`*_api_service.dart`)، وموديلز البيانات (`*_model.dart` / `*_request_body.dart`)، وتنفيذ المستودعات (`*_repo_impl.dart`).
* تقوم باصطياد الاستثناءات وتحويلها إلى `AppApiFailure`.

---

## 📂 هيكل المجلدات (Project Directory Structure)

```
lib/
├── core/                           # النواة المشتركة للمشروع
│   ├── app/                        # إعدادات التطبيق والمسافات (app_spaces) والأبعاد
│   ├── config/                     # ملفات البيئات (Dev / Prod EnvConfig)
│   ├── di/                         # Service Locator لحقن الاعتماديات (get_it)
│   ├── extensions/                 # ملحقات مساعدة للسياق والبيانات
│   ├── local_storage/              # إدارة التخزين المحلي الآمن
│   ├── network/                    # إعدادات Dio, ApiResult, ApiFailureMapper
│   ├── routes/                     # مسارات التطبيق و AppRouter
│   ├── styles/                     # الألوان، الخطوط، أحجام النصوص، الأيقونات
│   ├── theme/                      # ثيم التطبيق الموحد
│   ├── utils/                      # المسجل (AppLogger) و SafeEmitCubitMixin
│   ├── widgets/                    # المكونات العامة الموحدة (CustomButton, CustomTextFormField...)
│   └── core.dart                   # تصدير مركزي لمحتويات النواة
│
├── features/                       # ميزات التطبيق (Feature-First)
│   ├── splash/                     # شاشة البداية والتحقق من حالة المصادقة
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── auth/                       # نظام تسجيل الدخول والمصادقة
│   │   ├── data/
│   │   │   ├── apis/               # Retrofit AuthApiService
│   │   │   ├── models/             # UserModel, LoginRequestBody
│   │   │   └── repos/              # AuthRepoImpl
│   │   ├── domain/
│   │   │   ├── repos/              # AuthRepo (عقد مجرد)
│   │   │   └── use_cases/          # LoginUseCase
│   │   └── presentation/
│   │       ├── cubit/              # LoginCubit & LoginState (Freezed)
│   │       ├── screens/            # LoginScreen
│   │       └── widgets/            # LoginFormWidget, LoginBlocListener
│   └── home/                       # الشاشة الرئيسية وحجوزات الملاعب
│
├── assets/
│   ├── Fonts/                      # خطوط IBMPlexSansArabic و Fustat
│   ├── images/                     # الصور والأيقونات (PNGs / SVGs)
│   └── translations/               # ملفات اللغات (ar.json, en.json)
│
├── mal3abk_app.dart                # إعدادات MaterialApp و ScreenUtil
├── main_common.dart                # التهيئة المشتركة قبل تشغيل التطبيق
├── main_dev.dart                   # نقطة الدخول لبيئة التطوير (Dev)
├── main_prod.dart                  # نقطة الدخول لبيئة الإنتاج (Prod)
└── main.dart                       # نقطة الدخول الافتراضية
```

---

## 🚀 البدء والتشغيل (Getting Started)

### 1. المتطلبات الأساسية
* **Flutter SDK:** الإصدار `^3.10.4` أو أحدث.
* **Dart SDK:** الإصدار `^3.10.4` أو أحدث.

### 2. تثبيت الحزم
```bash
flutter pub get
```

### 3. توليد الأكواد (Code Generation)
عند إجراء أي تغيير على ملفات الـ `freezed` أو `json_serializable` أو `retrofit`:
```bash
dart run build_runner build --delete-conflicting-outputs --force-jit
```

### 4. تشغيل التطبيق حسب البيئة (Flavors)
* **بيئة التطوير (Development):**
  ```bash
  flutter run -t lib/main_dev.dart
  ```
* **بيئة الإنتاج (Production):**
  ```bash
  flutter run -t lib/main_prod.dart
  ```

---

## 🧪 الاختبارات وفحص الكود (Testing & Linting)

### فحص الكود (Linter & Analysis)
يخضع المشروع لقواعد فحص صارمة في `analysis_options.yaml`:
```bash
dart analyze
```
> يشترط اجتياز الفحص بنتيجة **0 Errors / 0 Warnings**.

### تشغيل الاختبارات
```bash
flutter test
```

---

## 📜 ميثاق العمل والقواعد (Project Rules)

للحصول على الدليل الإرشادي والتفصيلي الشامل للمطورين والمساعدين البرمجيين، يرجى مراجعة ملف [`rules.md`](file:///home/osama/Desktop/Mal3abk/rules.md) في جذر المشروع.
