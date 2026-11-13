import 'package:flutter/services.dart';

import '../extensions/app_display_extensions.dart';

/// Keeps only digits, turning Arabic-Indic digits (٠-٩) typed on an Arabic keyboard into Latin ones, and stops at
/// [maxLength] digits. For numbers that are not phone numbers, such as the last digits of a wallet.
class DigitsOnlyInputFormatter extends TextInputFormatter {
  const DigitsOnlyInputFormatter({this.maxLength});

  final int? maxLength;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.toLatinDigits().replaceAll(RegExp(r'\D'), '');
    if (maxLength != null && digits.length > maxLength!) {
      digits = digits.substring(0, maxLength);
    }
    return TextEditingValue(
      text: digits,
      selection: TextSelection.collapsed(offset: digits.length),
    );
  }
}
