import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/widgets/custom_button.dart';

void main() {
  testWidgets('shrinks a long label instead of overflowing', (tester) async {
    await tester.pumpWidget(
      ScreenUtilPlusInit(
        designSize: const Size(390, 844),
        builder: (_, _) => MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 134,
                child: CustomButton(
                  text: 'ابعت على واتساب ابعت على واتساب',
                  icon: const Icon(Icons.chat, size: 18),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    expect(tester.takeException(), isNull);
  });
}
