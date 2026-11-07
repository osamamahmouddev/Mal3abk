import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/settings/data/models/session_model.dart';

SessionModel _session({String? deviceName, required String userAgent}) =>
    SessionModel(
      sessionId: 's1',
      deviceName: deviceName,
      ipAddress: '127.0.0.1',
      userAgent: userAgent,
      createdAtUtc: DateTime.utc(2026, 11, 6),
      lastActivityAtUtc: DateTime.utc(2026, 11, 6),
      isCurrent: false,
    );

void main() {
  test('reads the platform from the app user agent', () {
    final session = _session(
      deviceName: 'Samsung SM-S911B',
      userAgent: 'Malabak/1.0.0 (Android 14)',
    );

    expect(session.deviceLabel, 'Samsung SM-S911B');
    expect(session.platformLabel, 'Android 14');
    expect(session.isApple, isFalse);
  });

  test('has no labels for the bare Dart agent of older builds', () {
    final session = _session(userAgent: 'Dart/3.10 (dart:io)');

    expect(session.deviceLabel, isNull);
    expect(session.platformLabel, isNull);
  });

  test('recognises Apple devices', () {
    final session = _session(
      deviceName: 'iPhone 15 Pro',
      userAgent: 'Malabak/1.0.0 (iOS 18.1)',
    );

    expect(session.isApple, isTrue);
  });
}
