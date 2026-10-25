import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../routes/routes.dart';
import '../styles/app_font_family.dart';

extension ContextExt on BuildContext {
  NavigatorState get navigator => Navigator.of(this);

  String get currentFontFamily {
    return AppFontFamily.getFontFamily(locale.languageCode);
  }

  bool get isArabic => locale.languageCode == 'ar';
  bool get isEnglish => locale.languageCode == 'en';

  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator.pushNamed<T>(routeName, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return navigator.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  void pop<T extends Object?>([T? result]) => navigator.pop<T>(result);

  /// Opens the main shell on the root navigator and clears the whole stack,
  /// so it is never nested inside a tab's navigator.
  void openMainShell() => Navigator.of(this, rootNavigator: true)
      .pushNamedAndRemoveUntil(AppRoutes.main, (_) => false);
}
