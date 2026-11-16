import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/security/screen_security.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late List<MethodCall> calls;
  late ScreenSecurity screenSecurity;

  setUp(() {
    calls = <MethodCall>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('com.malabak.app/security'),
          (call) async {
            calls.add(call);
            if (call.method == 'setSecure') {
              return true;
            }
            return null;
          },
        );
    screenSecurity = const ScreenSecurity();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('com.malabak.app/security'),
          null,
        );
  });

  test('invokes setSecure with true to enable protection', () async {
    final result = await screenSecurity.setSecure(true);

    expect(result, isTrue);
    expect(calls, hasLength(1));
    expect(calls.first.method, equals('setSecure'));
    expect(calls.first.arguments, equals({'secure': true}));
  });

  test('invokes setSecure with false to disable protection', () async {
    final result = await screenSecurity.setSecure(false);

    expect(result, isTrue);
    expect(calls, hasLength(1));
    expect(calls.first.arguments, equals({'secure': false}));
  });

  test('handles missing channel gracefully without throwing', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('com.malabak.app/security'),
          null,
        );

    final result = await screenSecurity.setSecure(true);
    expect(result, isFalse);
  });
}
