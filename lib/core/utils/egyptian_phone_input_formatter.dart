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
    var digits = newValue.text.toLatinDigits().replaceAll(RegExp(r'\D'), '');

    // Strip Egyptian international prefixes if pasted (+20 / 0020 / 20)
    if (digits.startsWith('0020')) {
      digits = digits.substring(4);
    } else if (digits.startsWith('20') && digits.length >= 12) {
      digits = digits.substring(2);
    }

    // Ensure leading 0 for national format (e.g. if 1000000999 was passed)
    if (digits.startsWith('1') && digits.length == 10) {
      digits = '0$digits';
    }

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
