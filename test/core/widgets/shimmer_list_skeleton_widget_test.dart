import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/widgets/shimmer_list_skeleton_widget.dart';

Widget _app(Widget body) => ScreenUtilPlusInit(
  designSize: const Size(390, 844),
  builder: (_, _) => MaterialApp(home: Scaffold(body: body)),
);

void main() {
  testWidgets('lays out inside another scrollable', (tester) async {
    await tester.pumpWidget(
      _app(
        ListView(
          children: const [
            Column(children: [ShimmerListSkeletonWidget(itemHeight: 96)]),
          ],
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(tester.takeException(), isNull);
    expect(find.byType(ShimmerListSkeletonWidget), findsOneWidget);
  });

  testWidgets('clips instead of overflowing a bounded height', (tester) async {
    await tester.pumpWidget(
      _app(const ShimmerListSkeletonWidget(itemHeight: 400, itemCount: 4)),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(tester.takeException(), isNull);
  });
}
