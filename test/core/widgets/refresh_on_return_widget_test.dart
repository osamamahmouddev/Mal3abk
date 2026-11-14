import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/widgets/refresh_on_return_widget.dart';

void main() {
  late int returns;
  final navigatorKey = GlobalKey<NavigatorState>();

  setUp(() => returns = 0);

  Widget app({bool tickersOn = true}) => MaterialApp(
    navigatorKey: navigatorKey,
    home: TickerMode(
      enabled: tickersOn,
      child: RefreshOnReturnWidget(
        onReturn: () => returns++,
        child: const Text('list'),
      ),
    ),
  );

  Future<void> pushOnTop(WidgetTester tester) async {
    navigatorKey.currentState!.push(
      MaterialPageRoute<void>(builder: (_) => const Text('detail')),
    );
    await tester.pumpAndSettle();
  }

  Future<void> popBack(WidgetTester tester) async {
    navigatorKey.currentState!.pop();
    await tester.pumpAndSettle();
  }

  testWidgets('the first build is not a return', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(returns, 0);
  });

  testWidgets('a screen pushed on top does not count', (tester) async {
    await tester.pumpWidget(app());
    await pushOnTop(tester);
    expect(returns, 0);
  });

  testWidgets('coming back from a pushed screen counts once', (tester) async {
    await tester.pumpWidget(app());
    await pushOnTop(tester);
    await popBack(tester);
    expect(returns, 1);
  });

  testWidgets('every return counts', (tester) async {
    await tester.pumpWidget(app());
    for (var i = 0; i < 3; i++) {
      await pushOnTop(tester);
      await popBack(tester);
    }
    expect(returns, 3);
  });

  testWidgets('a rebuild while in view is not a return', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    expect(returns, 0);
  });

  testWidgets('its tab being selected again counts', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpWidget(app(tickersOn: false)); // another tab selected
    await tester.pumpAndSettle();
    expect(returns, 0);
    await tester.pumpWidget(app()); // back to this tab
    await tester.pumpAndSettle();
    expect(returns, 1);
  });
}
