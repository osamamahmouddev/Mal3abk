import 'package:flutter/services.dart';

import '../extensions/app_display_extensions.dart';

/// Keeps an Egyptian mobile number to 11 Latin digits shown as
/// "010 1234 5678"; the spaces are ignored when the number is normalized.
class EgyptianPhoneInputFormatter extends TextInputFormatter {
  const EgyptianPhoneInputFormatter();

  static const int maxDigits = 11;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.toLatinDigits().replaceAll(RegExp(r'\D'), '');
    final trimmed = digits.length > maxDigits
        ? digits.substring(0, maxDigits)
        : digits;
    final buffer = StringBuffer();
    for (var i = 0; i < trimmed.length; i++) {
      if (i == 3 || i == 7) buffer.write(' ');
      buffer.write(trimmed[i]);
    }
    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
