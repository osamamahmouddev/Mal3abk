import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/utils/digits_only_input_formatter.dart';

TextEditingValue _type(DigitsOnlyInputFormatter formatter, String text) =>
    formatter.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: text),
    );

void main() {
  const formatter = DigitsOnlyInputFormatter(maxLength: 11);

  test('keeps digits and drops letters, spaces and symbols', () {
    expect(_type(formatter, 'ab12 3-4+5').text, '12345');
  });

  test('turns Arabic-Indic digits into Latin digits', () {
    expect(_type(formatter, '٠١٢٣٤٥').text, '012345');
    expect(_type(formatter, '۰۱۲').text, '012');
  });

  test('stops at the maximum length', () {
    expect(_type(formatter, '1234567890123').text, '12345678901');
  });

  test('puts the cursor at the end', () {
    final value = _type(formatter, '12a');

    expect(value.selection.baseOffset, 2);
  });

  test('an empty or all-text input becomes empty', () {
    expect(_type(formatter, '').text, '');
    expect(_type(formatter, 'abc').text, '');
  });
}
