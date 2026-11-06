import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/explore/presentation/screens/photo_gallery_screen.dart';
import 'package:mal3abk/features/explore/presentation/widgets/venue_hero_button_widget.dart';

const _photos = [
  'https://example.test/1.jpg',
  'https://example.test/2.jpg',
  'https://example.test/3.jpg',
];

void main() {
  late int? popped;

  Future<void> openGallery(WidgetTester tester, {int initialIndex = 0}) async {
    popped = null;
    await tester.pumpWidget(
      ScreenUtilPlusInit(
        designSize: const Size(390, 844),
        builder: (_, _) => MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                popped = await Navigator.of(context).push<int>(
                  MaterialPageRoute(
                    builder: (_) => PhotoGalleryScreen(
                      args: PhotoGalleryArgs(
                        photos: _photos,
                        initialIndex: initialIndex,
                      ),
                    ),
                  ),
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  testWidgets('opens on the tapped photo', (tester) async {
    await openGallery(tester, initialIndex: 1);

    expect(find.text('2 / 3'), findsOneWidget);
  });

  testWidgets('swipes to the next photo', (tester) async {
    await openGallery(tester);

    await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('2 / 3'), findsOneWidget);
  });

  testWidgets('closes with the photo last shown', (tester) async {
    await openGallery(tester, initialIndex: 2);

    await tester.tap(find.byType(VenueHeroButtonWidget));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(popped, 2);
  });
}
