# Flutter Wrapper rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep the application activity and classes
-keep class com.example.mal3abk.** { *; }
-keep class com.systmgulf.mal3abk.** { *; }

# Keep attributes needed for reflection and annotations
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod

# Firebase Messaging
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Google Play Services & Maps
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# AndroidX Biometrics (local_auth)
-keep class androidx.biometric.** { *; }
-dontwarn androidx.biometric.**

# Flutter Secure Storage
-keep class androidx.security.crypto.** { *; }
-keep class com.it_nomads.fluttersecurestorage.** { *; }
