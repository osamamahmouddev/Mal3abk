import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/utils/egyptian_phone_input_formatter.dart';

void main() {
  String format(String input) => const EgyptianPhoneInputFormatter()
      .formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: input))
      .text;

  test('groups the number as 010 1234 5678', () {
    expect(format('01012345678'), '010 1234 5678');
    expect(format('0101'), '010 1');
  });

  test('accepts Arabic digits and drops anything else', () {
    expect(format('٠١٠١٢٣٤٥٦٧٨'), '010 1234 5678');
    expect(format('010-12a34'), '010 1234');
  });

  test('stops at eleven digits', () {
    expect(format('010123456789999'), '010 1234 5678');
  });
}
