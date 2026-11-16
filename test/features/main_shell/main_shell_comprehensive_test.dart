import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/explore/data/models/explore_filter_model.dart';
import 'package:mal3abk/features/main_shell/presentation/widgets/main_shell_scope_widget.dart';

void main() {
  group('MainShellScopeWidget Constants Tests', () {
    test('1. homeTab is 0', () {
      expect(MainShellScopeWidget.homeTab, 0);
    });

    test('2. exploreTab is 1', () {
      expect(MainShellScopeWidget.exploreTab, 1);
    });

    test('3. bookingsTab is 2', () {
      expect(MainShellScopeWidget.bookingsTab, 2);
    });

    test('4. teamsTab is 3', () {
      expect(MainShellScopeWidget.teamsTab, 3);
    });

    test('5. profileTab is 4', () {
      expect(MainShellScopeWidget.profileTab, 4);
    });

    test('6. updateShouldNotify always returns false', () {
      final notifier = ValueNotifier<ExploreFilterModel?>(null);
      final widget1 = MainShellScopeWidget(
        onSwitchTab: (_) {},
        exploreRequest: notifier,
        child: const SizedBox(),
      );
      final widget2 = MainShellScopeWidget(
        onSwitchTab: (_) {},
        exploreRequest: notifier,
        child: const SizedBox(),
      );
      expect(widget1.updateShouldNotify(widget2), isFalse);
    });
  });

  group('MainShellScopeWidget Functional Widget Tests', () {
    testWidgets('7. switchTab calls onSwitchTab callback with requested tab index', (tester) async {
      int? switchedIndex;
      final notifier = ValueNotifier<ExploreFilterModel?>(null);

      await tester.pumpWidget(
        MaterialApp(
          home: MainShellScopeWidget(
            onSwitchTab: (index) => switchedIndex = index,
            exploreRequest: notifier,
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => MainShellScopeWidget.switchTab(context, MainShellScopeWidget.bookingsTab),
                child: const Text('Go Bookings'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go Bookings'));
      await tester.pump();

      expect(switchedIndex, MainShellScopeWidget.bookingsTab);
    });

    testWidgets('8. openExplore sets filter and switches to exploreTab', (tester) async {
      int? switchedIndex;
      final notifier = ValueNotifier<ExploreFilterModel?>(null);
      const testFilter = ExploreFilterModel();

      await tester.pumpWidget(
        MaterialApp(
          home: MainShellScopeWidget(
            onSwitchTab: (index) => switchedIndex = index,
            exploreRequest: notifier,
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => MainShellScopeWidget.openExplore(context, testFilter),
                child: const Text('Open Explore'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Explore'));
      await tester.pump();

      expect(switchedIndex, MainShellScopeWidget.exploreTab);
      expect(notifier.value, equals(testFilter));
    });

    testWidgets('9. exploreRequestOf returns the provided ValueNotifier', (tester) async {
      final notifier = ValueNotifier<ExploreFilterModel?>(null);
      ValueNotifier<ExploreFilterModel?>? retrievedNotifier;

      await tester.pumpWidget(
        MaterialApp(
          home: MainShellScopeWidget(
            onSwitchTab: (_) {},
            exploreRequest: notifier,
            child: Builder(
              builder: (context) {
                retrievedNotifier = MainShellScopeWidget.exploreRequestOf(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(retrievedNotifier, same(notifier));
    });

    testWidgets('10. switchTab does nothing if called outside MainShellScopeWidget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Should not throw
              MainShellScopeWidget.switchTab(context, 1);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('11. openExplore does nothing if called outside MainShellScopeWidget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              // Should not throw
              MainShellScopeWidget.openExplore(context, const ExploreFilterModel());
              return const SizedBox();
            },
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('12. exploreRequestOf returns null if called outside MainShellScopeWidget', (tester) async {
      ValueNotifier<ExploreFilterModel?>? retrieved;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              retrieved = MainShellScopeWidget.exploreRequestOf(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(retrieved, isNull);
    });
  });

  group('MainShellScope Parameterized Tab Switching Tests (13-50)', () {
    for (var i = 13; i <= 50; i++) {
      testWidgets('$i. switchTab to index ${i % 5}', (tester) async {
        int? target;
        final notifier = ValueNotifier<ExploreFilterModel?>(null);

        await tester.pumpWidget(
          MaterialApp(
            home: MainShellScopeWidget(
              onSwitchTab: (idx) => target = idx,
              exploreRequest: notifier,
              child: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => MainShellScopeWidget.switchTab(context, i % 5),
                  child: Text('Tab ${i % 5}'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Tab ${i % 5}'));
        await tester.pump();
        expect(target, i % 5);
      });
    }
  });

  group('MainShellScope Parameterized Filter Dispatch Tests (51-100)', () {
    for (var i = 51; i <= 100; i++) {
      testWidgets('$i. openExplore with startHour ${i % 24}', (tester) async {
        int? target;
        final notifier = ValueNotifier<ExploreFilterModel?>(null);
        final filter = ExploreFilterModel(startHour: i % 24);

        await tester.pumpWidget(
          MaterialApp(
            home: MainShellScopeWidget(
              onSwitchTab: (idx) => target = idx,
              exploreRequest: notifier,
              child: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => MainShellScopeWidget.openExplore(context, filter),
                  child: Text('Filter $i'),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Filter $i'));
        await tester.pump();

        expect(target, MainShellScopeWidget.exploreTab);
        expect(notifier.value?.startHour, i % 24);
      });
    }
  });
}
