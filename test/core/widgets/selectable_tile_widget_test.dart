import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/widgets/selectable_tile_widget.dart';

void main() {
  testWidgets('a long title and subtitle fit the tile without overflowing', (
    tester,
  ) async {
    // The app's design size, so 1 logical unit is 1 pixel.
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ScreenUtilPlusInit(
        designSize: const Size(390, 844),
        builder: (_, _) => MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 150,
                child: SelectableTileWidget(
                  title: 'ملعب التتش الصغير (خماسي) الجديد جداً',
                  subtitle: 'من ٦٠٠ ج.م للساعة الواحدة',
                  isSelected: false,
                  onTap: () {},
                  height: 76,
                  horizontalPadding: 10,
                  borderRadius: 14,
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
