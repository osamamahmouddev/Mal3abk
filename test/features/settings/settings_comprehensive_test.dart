import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/core/network/app_api_failure.dart';
import 'package:mal3abk/core/security/biometric_lock.dart';
import 'package:retrofit/retrofit.dart';
import 'package:mal3abk/features/notifications/domain/repos/notifications_repo.dart';
import 'package:mal3abk/features/settings/data/apis/account_api_service.dart';
import 'package:mal3abk/features/settings/data/models/consents_model.dart';
import 'package:mal3abk/features/settings/data/models/language_request_body.dart';
import 'package:mal3abk/features/settings/data/models/record_consent_request_body.dart';
import 'package:mal3abk/features/settings/data/models/session_model.dart';
import 'package:mal3abk/features/settings/data/repos/account_repo_impl.dart';
import 'package:mal3abk/features/settings/domain/repos/account_repo.dart';
import 'package:mal3abk/features/settings/domain/use_cases/delete_account_use_case.dart';
import 'package:mal3abk/features/settings/presentation/cubit/account_action.dart';
import 'package:mal3abk/features/settings/presentation/cubit/account_action_cubit.dart';
import 'package:mal3abk/features/settings/presentation/cubit/account_action_state.dart';
import 'package:mal3abk/features/settings/presentation/cubit/biometric_lock_cubit.dart';
import 'package:mal3abk/features/settings/presentation/cubit/biometric_lock_state.dart';
import 'package:mal3abk/features/settings/presentation/cubit/consents_cubit.dart';
import 'package:mal3abk/features/settings/presentation/cubit/consents_state.dart';
import 'package:mal3abk/features/settings/presentation/cubit/notification_preferences_cubit.dart';
import 'package:mal3abk/features/settings/presentation/cubit/notification_preferences_state.dart';
import 'package:mal3abk/features/settings/presentation/cubit/sessions_cubit.dart';
import 'package:mal3abk/features/settings/presentation/cubit/sessions_state.dart';
import 'package:mocktail/mocktail.dart';

class MockAccountApiService extends Mock implements AccountApiService {}
class MockAccountRepo extends Mock implements AccountRepo {}
class MockDeleteAccountUseCase extends Mock implements DeleteAccountUseCase {}
class MockBiometricLock extends Mock implements BiometricLock {}
class MockNotificationsRepo extends Mock implements NotificationsRepo {}

SessionModel _makeSession({
  required String id,
  String? deviceName,
  String ipAddress = '192.168.1.1',
  String userAgent = 'Malabak/1.0.0 (Android 14)',
  DateTime? createdAt,
  DateTime? lastActivityAt,
  bool isCurrent = false,
}) {
  return SessionModel(
    sessionId: id,
    deviceName: deviceName,
    ipAddress: ipAddress,
    userAgent: userAgent,
    createdAtUtc: createdAt ?? DateTime.utc(2026, 1, 1),
    lastActivityAtUtc: lastActivityAt ?? DateTime.utc(2026, 1, 2),
    isCurrent: isCurrent,
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(ConsentType.notifications);
    registerFallbackValue(const RecordConsentRequestBody(
      type: ConsentType.notifications,
      granted: true,
    ));
    registerFallbackValue(const LanguageRequestBody(language: 'ar'));
  });

  group('SessionModel Comprehensive Tests', () {
    test('1. SessionModel parses all fields from json', () {
      final json = {
        'sessionId': 's-1',
        'deviceName': 'Samsung Galaxy S23',
        'ipAddress': '192.168.1.5',
        'userAgent': 'Malabak/2.1.0 (Android 14)',
        'createdAtUtc': '2026-02-01T10:00:00.000Z',
        'lastActivityAtUtc': '2026-02-01T12:00:00.000Z',
        'isCurrent': true,
      };
      final s = SessionModel.fromJson(json);
      expect(s.sessionId, 's-1');
      expect(s.deviceName, 'Samsung Galaxy S23');
      expect(s.ipAddress, '192.168.1.5');
      expect(s.isCurrent, isTrue);
    });

    test('2. SessionModel toJson contains all serialized keys', () {
      final s = _makeSession(id: 's-2', deviceName: 'Pixel 8', isCurrent: false);
      final json = s.toJson();
      expect(json['sessionId'], 's-2');
      expect(json['deviceName'], 'Pixel 8');
      expect(json['isCurrent'], isFalse);
    });

    test('3. deviceLabel returns trimmed name when present', () {
      final s = _makeSession(id: 's-3', deviceName: '   Xiaomi 13   ');
      expect(s.deviceLabel, 'Xiaomi 13');
    });

    test('4. deviceLabel returns null when deviceName is empty or whitespaces', () {
      final s1 = _makeSession(id: 's-4a', deviceName: '');
      final s2 = _makeSession(id: 's-4b', deviceName: '   ');
      final s3 = _makeSession(id: 's-4c', deviceName: null);
      expect(s1.deviceLabel, isNull);
      expect(s2.deviceLabel, isNull);
      expect(s3.deviceLabel, isNull);
    });

    test('5. platformLabel extracts OS from standard Malabak user agent', () {
      final s = _makeSession(id: 's-5', userAgent: 'Malabak/2.0.0 (Android 13; Build 44)');
      expect(s.platformLabel, 'Android 13; Build 44');
    });

    test('6. platformLabel extracts iOS version correctly', () {
      final s = _makeSession(id: 's-6', userAgent: 'Malabak/1.5.0 (iOS 17.4)');
      expect(s.platformLabel, 'iOS 17.4');
    });

    test('7. platformLabel returns null for legacy Dart agent', () {
      final s = _makeSession(id: 's-7', userAgent: 'Dart/3.3 (dart:io)');
      expect(s.platformLabel, isNull);
    });

    test('8. isApple returns true when deviceName has iPhone', () {
      final s = _makeSession(id: 's-8', deviceName: 'iPhone 15 Pro');
      expect(s.isApple, isTrue);
    });

    test('9. isApple returns true when deviceName has iPad', () {
      final s = _makeSession(id: 's-9', deviceName: 'iPad Air 5');
      expect(s.isApple, isTrue);
    });

    test('10. isApple returns true when userAgent has iOS', () {
      final s = _makeSession(id: 's-10', deviceName: null, userAgent: 'Malabak/1.0 (iOS 16.5)');
      expect(s.isApple, isTrue);
    });

    test('11. isApple is case-insensitive', () {
      final s = _makeSession(id: 's-11', deviceName: 'IPHONE 14');
      expect(s.isApple, isTrue);
    });

    test('12. isApple returns false for Android devices', () {
      final s = _makeSession(id: 's-12', deviceName: 'Google Pixel 7 Pro', userAgent: 'Malabak/1.0 (Android 14)');
      expect(s.isApple, isFalse);
    });

    test('13. isApple returns false for generic client agent', () {
      final s = _makeSession(id: 's-13', deviceName: null, userAgent: 'Mozilla/5.0');
      expect(s.isApple, isFalse);
    });

    test('14. SessionModel handles empty deviceName in isApple check without crashing', () {
      final s = _makeSession(id: 's-14', deviceName: null, userAgent: '');
      expect(s.isApple, isFalse);
    });

    test('15. SessionModel handles current vs non-current', () {
      final s1 = _makeSession(id: 's-15a', isCurrent: true);
      final s2 = _makeSession(id: 's-15b', isCurrent: false);
      expect(s1.isCurrent, isTrue);
      expect(s2.isCurrent, isFalse);
    });
  });

  group('Consents & Request Models Tests', () {
    test('16. ConsentModel parses all fields from json', () {
      final json = {
        'type': 'Notifications',
        'granted': true,
        'version': 'v1.0',
        'recordedAtUtc': '2026-01-01T00:00:00.000Z',
      };
      final consent = ConsentModel.fromJson(json);
      expect(consent.type, 'Notifications');
      expect(consent.granted, isTrue);
      expect(consent.version, 'v1.0');
    });

    test('17. ConsentModel handles null version', () {
      final json = {
        'type': 'Marketing',
        'granted': false,
        'recordedAtUtc': '2026-01-01T00:00:00.000Z',
      };
      final consent = ConsentModel.fromJson(json);
      expect(consent.version, isNull);
      expect(consent.granted, isFalse);
    });

    test('18. ConsentModel toJson serializes accurately', () {
      final consent = ConsentModel(
        type: 'Location',
        granted: true,
        version: 'v2',
        recordedAtUtc: DateTime.utc(2026, 1, 1),
      );
      final json = consent.toJson();
      expect(json['type'], 'Location');
      expect(json['granted'], isTrue);
      expect(json['version'], 'v2');
    });

    test('19. ConsentsModel default constructor has empty current and history', () {
      const consents = ConsentsModel();
      expect(consents.current, isEmpty);
      expect(consents.history, isEmpty);
    });

    test('20. ConsentsModel isGranted returns true if granted is true', () {
      final consents = ConsentsModel(
        current: [
          ConsentModel(type: 'Notifications', granted: true, recordedAtUtc: DateTime.utc(2026, 1, 1)),
          ConsentModel(type: 'Marketing', granted: false, recordedAtUtc: DateTime.utc(2026, 1, 1)),
        ],
      );
      expect(consents.isGranted('Notifications'), isTrue);
    });

    test('21. ConsentsModel isGranted returns false if granted is false', () {
      final consents = ConsentsModel(
        current: [
          ConsentModel(type: 'Marketing', granted: false, recordedAtUtc: DateTime.utc(2026, 1, 1)),
        ],
      );
      expect(consents.isGranted('Marketing'), isFalse);
    });

    test('22. ConsentsModel isGranted returns false for missing consent type', () {
      final consents = ConsentsModel(
        current: [
          ConsentModel(type: 'Location', granted: true, recordedAtUtc: DateTime.utc(2026, 1, 1)),
        ],
      );
      expect(consents.isGranted('Notifications'), isFalse);
    });

    test('23. ConsentsModel fromJson parses nested lists', () {
      final json = {
        'current': [
          {'type': 'Notifications', 'granted': true, 'recordedAtUtc': '2026-01-01T00:00:00.000Z'},
        ],
        'history': [
          {'type': 'Notifications', 'granted': false, 'recordedAtUtc': '2025-12-01T00:00:00.000Z'},
        ],
      };
      final consents = ConsentsModel.fromJson(json);
      expect(consents.current.length, 1);
      expect(consents.history.length, 1);
      expect(consents.isGranted('Notifications'), isTrue);
    });

    test('24. ConsentType serverName mappings', () {
      expect(ConsentType.notifications.serverName, 'Notifications');
      expect(ConsentType.location.serverName, 'Location');
      expect(ConsentType.marketing.serverName, 'Marketing');
    });

    test('25. ConsentType enum values contain 3 variants', () {
      expect(ConsentType.values.length, 3);
      expect(ConsentType.values, contains(ConsentType.notifications));
      expect(ConsentType.values, contains(ConsentType.location));
      expect(ConsentType.values, contains(ConsentType.marketing));
    });

    test('26. RecordConsentRequestBody fromJson and toJson', () {
      const body = RecordConsentRequestBody(type: ConsentType.notifications, granted: true);
      final json = body.toJson();
      expect(json['type'], 2);
      expect(json['granted'], isTrue);

      final parsed = RecordConsentRequestBody.fromJson(json);
      expect(parsed.type, ConsentType.notifications);
      expect(parsed.granted, isTrue);
    });

    test('27. RecordConsentRequestBody location variant serialization', () {
      const body = RecordConsentRequestBody(type: ConsentType.location, granted: false);
      expect(body.toJson()['type'], 3);
      expect(body.toJson()['granted'], isFalse);
    });

    test('28. RecordConsentRequestBody marketing variant serialization', () {
      const body = RecordConsentRequestBody(type: ConsentType.marketing, granted: true);
      expect(body.toJson()['type'], 4);
      expect(body.toJson()['granted'], isTrue);
    });

    test('29. LanguageRequestBody fromJson and toJson', () {
      const body = LanguageRequestBody(language: 'ar');
      final json = body.toJson();
      expect(json['language'], 'ar');

      final parsed = LanguageRequestBody.fromJson(json);
      expect(parsed.language, 'ar');
    });

    test('30. LanguageRequestBody en variant', () {
      const body = LanguageRequestBody(language: 'en');
      expect(body.toJson()['language'], 'en');
    });
  });

  group('AccountRepoImpl Tests', () {
    late MockAccountApiService api;
    late AccountRepoImpl repo;

    setUp(() {
      api = MockAccountApiService();
      repo = AccountRepoImpl(accountApiService: api);
    });

    test('31. getSessions returns list of sessions on success', () async {
      final list = [_makeSession(id: 's1'), _makeSession(id: 's2')];
      when(() => api.getSessions()).thenAnswer((_) async => list);

      final res = await repo.getSessions();
      expect(res, isA<Success<List<SessionModel>>>());
      expect((res as Success<List<SessionModel>>).data.length, 2);
    });

    test('32. getSessions catches DioException and returns failure', () async {
      when(() => api.getSessions()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/api/sessions'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final res = await repo.getSessions();
      expect(res, isA<ApiFailure<List<SessionModel>>>());
    });

    test('33. revokeSession delegates sessionId to api and succeeds', () async {
      when(() => api.revokeSession('s1')).thenAnswer((_) async {});

      final res = await repo.revokeSession('s1');
      expect(res, isA<Success<void>>());
      verify(() => api.revokeSession('s1')).called(1);
    });

    test('34. revokeSession maps DioException to failure', () async {
      when(() => api.revokeSession('s1')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/api/sessions/s1'),
          response: Response(statusCode: 404, requestOptions: RequestOptions(path: '/')),
        ),
      );

      final res = await repo.revokeSession('s1');
      expect(res, isA<ApiFailure<void>>());
    });

    test('35. revokeOtherSessions delegates to api and succeeds', () async {
      when(() => api.revokeOtherSessions()).thenAnswer((_) async {});

      final res = await repo.revokeOtherSessions();
      expect(res, isA<Success<void>>());
      verify(() => api.revokeOtherSessions()).called(1);
    });

    test('36. revokeOtherSessions returns failure on error', () async {
      when(() => api.revokeOtherSessions()).thenThrow(Exception('Server error'));

      final res = await repo.revokeOtherSessions();
      expect(res, isA<ApiFailure<void>>());
    });

    test('37. getConsents returns ConsentsModel on success', () async {
      const consents = ConsentsModel();
      when(() => api.getConsents()).thenAnswer((_) async => consents);

      final res = await repo.getConsents();
      expect(res, isA<Success<ConsentsModel>>());
    });

    test('38. getConsents returns failure on network error', () async {
      when(() => api.getConsents()).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/consents'), type: DioExceptionType.receiveTimeout),
      );

      final res = await repo.getConsents();
      expect(res, isA<ApiFailure<ConsentsModel>>());
    });

    test('39. recordConsent passes correct RecordConsentRequestBody and returns updated consents', () async {
      const consents = ConsentsModel();
      when(() => api.recordConsent(any())).thenAnswer((_) async => consents);

      final res = await repo.recordConsent(ConsentType.notifications, granted: true);
      expect(res, isA<Success<ConsentsModel>>());
      verify(() => api.recordConsent(any(that: isA<RecordConsentRequestBody>()))).called(1);
    });

    test('40. recordConsent returns failure when api fails', () async {
      when(() => api.recordConsent(any())).thenThrow(Exception('Failed'));

      final res = await repo.recordConsent(ConsentType.location, granted: false);
      expect(res, isA<ApiFailure<ConsentsModel>>());
    });

    test('41. setLanguage passes LanguageRequestBody to api', () async {
      when(() => api.setLanguage(any())).thenAnswer((_) async {});

      final res = await repo.setLanguage('ar');
      expect(res, isA<Success<void>>());
      verify(() => api.setLanguage(any(that: isA<LanguageRequestBody>()))).called(1);
    });

    test('42. setLanguage returns failure on error', () async {
      when(() => api.setLanguage(any())).thenThrow(Exception('Lang error'));

      final res = await repo.setLanguage('en');
      expect(res, isA<ApiFailure<void>>());
    });

    test('43. exportData calls api with stepUpToken and returns Uint8List', () async {
      final bytes = [1, 2, 3, 4, 5];
      when(() => api.exportData('token-123')).thenAnswer(
        (_) async => HttpResponse<List<int>>(
          bytes,
          Response(statusCode: 200, requestOptions: RequestOptions(path: '/export')),
        ),
      );

      final res = await repo.exportData(stepUpToken: 'token-123');
      expect(res, isA<Success<Uint8List>>());
      expect((res as Success<Uint8List>).data, equals(Uint8List.fromList(bytes)));
    });

    test('44. exportData returns failure on 401 unauthorized', () async {
      when(() => api.exportData('bad-token')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/export'),
          response: Response(statusCode: 401, requestOptions: RequestOptions(path: '/')),
        ),
      );

      final res = await repo.exportData(stepUpToken: 'bad-token');
      expect(res, isA<ApiFailure<Uint8List>>());
    });

    test('45. deleteAccount delegates stepUpToken to api', () async {
      when(() => api.deleteAccount('step-token')).thenAnswer((_) async {});

      final res = await repo.deleteAccount(stepUpToken: 'step-token');
      expect(res, isA<Success<void>>());
      verify(() => api.deleteAccount('step-token')).called(1);
    });
  });

  group('AccountActionCubit Tests', () {
    late MockAccountRepo mockRepo;
    late MockDeleteAccountUseCase mockDeleteUseCase;
    late AccountActionCubit cubit;

    setUp(() {
      mockRepo = MockAccountRepo();
      mockDeleteUseCase = MockDeleteAccountUseCase();
      cubit = AccountActionCubit(
        accountRepo: mockRepo,
        deleteAccountUseCase: mockDeleteUseCase,
      );
    });

    tearDown(() => cubit.close());

    test('46. Initial state is AccountActionInitial', () {
      expect(cubit.state, const AccountActionState.initial());
    });

    test('47. changeLanguage ignores unsupported language codes', () async {
      await cubit.changeLanguage('fr');
      await cubit.changeLanguage('de');
      await cubit.changeLanguage('');
      expect(cubit.state, const AccountActionState.initial());
      verifyNever(() => mockRepo.setLanguage(any()));
    });

    test('48. changeLanguage succeeds with ar and emits [loading, languageChanged]', () async {
      when(() => mockRepo.setLanguage('ar')).thenAnswer((_) async => const ApiResult.success(null));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AccountActionState.loading(AccountAction.changeLanguage),
          const AccountActionState.languageChanged('ar'),
        ]),
      );

      await cubit.changeLanguage('ar');
    });

    test('49. changeLanguage succeeds with en and emits [loading, languageChanged]', () async {
      when(() => mockRepo.setLanguage('en')).thenAnswer((_) async => const ApiResult.success(null));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AccountActionState.loading(AccountAction.changeLanguage),
          const AccountActionState.languageChanged('en'),
        ]),
      );

      await cubit.changeLanguage('en');
    });

    test('50. changeLanguage emits error on repo failure', () async {
      when(() => mockRepo.setLanguage('ar')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.language_failed')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AccountActionState.loading(AccountAction.changeLanguage),
          const AccountActionState.error('errors.language_failed'),
        ]),
      );

      await cubit.changeLanguage('ar');
    });

    test('51. changeLanguage is ignored when already busy', () async {
      when(() => mockRepo.setLanguage('ar')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return const ApiResult.success(null);
      });

      final f1 = cubit.changeLanguage('ar');
      final f2 = cubit.changeLanguage('ar');
      await Future.wait([f1, f2]);

      verify(() => mockRepo.setLanguage('ar')).called(1);
    });

    test('52. exportData emits [loading, exported] on success', () async {
      final bytes = Uint8List.fromList([1, 2, 3]);
      when(() => mockRepo.exportData(stepUpToken: 'tok')).thenAnswer((_) async => ApiResult.success(bytes));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AccountActionState.loading(AccountAction.exportData),
          AccountActionState.exported(bytes),
        ]),
      );

      await cubit.exportData(stepUpToken: 'tok');
    });

    test('53. exportData emits error on failure', () async {
      when(() => mockRepo.exportData(stepUpToken: 'tok')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.export_failed')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AccountActionState.loading(AccountAction.exportData),
          const AccountActionState.error('errors.export_failed'),
        ]),
      );

      await cubit.exportData(stepUpToken: 'tok');
    });

    test('54. exportData is ignored when already busy', () async {
      when(() => mockRepo.exportData(stepUpToken: 'tok')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return ApiResult.success(Uint8List(0));
      });

      final f1 = cubit.exportData(stepUpToken: 'tok');
      final f2 = cubit.exportData(stepUpToken: 'tok');
      await Future.wait([f1, f2]);

      verify(() => mockRepo.exportData(stepUpToken: 'tok')).called(1);
    });

    test('55. deleteAccount emits [loading, deleted] on success', () async {
      when(() => mockDeleteUseCase(stepUpToken: 'tok')).thenAnswer((_) async => const ApiResult.success(null));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AccountActionState.loading(AccountAction.deleteAccount),
          const AccountActionState.deleted(),
        ]),
      );

      await cubit.deleteAccount(stepUpToken: 'tok');
    });

    test('56. deleteAccount emits error on failure', () async {
      when(() => mockDeleteUseCase(stepUpToken: 'tok')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.delete_failed')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AccountActionState.loading(AccountAction.deleteAccount),
          const AccountActionState.error('errors.delete_failed'),
        ]),
      );

      await cubit.deleteAccount(stepUpToken: 'tok');
    });

    test('57. deleteAccount is ignored when busy', () async {
      when(() => mockDeleteUseCase(stepUpToken: 'tok')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return const ApiResult.success(null);
      });

      final f1 = cubit.deleteAccount(stepUpToken: 'tok');
      final f2 = cubit.deleteAccount(stepUpToken: 'tok');
      await Future.wait([f1, f2]);

      verify(() => mockDeleteUseCase(stepUpToken: 'tok')).called(1);
    });

    test('58. AccountActionCubit is safe when closed during request', () async {
      when(() => mockRepo.setLanguage('ar')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return const ApiResult.success(null);
      });

      final f = cubit.changeLanguage('ar');
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });

    test('59. supportedLanguages contains only ar and en', () {
      expect(AccountActionCubit.supportedLanguages, {'ar', 'en'});
    });

    test('60. AccountAction enum values check', () {
      expect(AccountAction.values, contains(AccountAction.changeLanguage));
      expect(AccountAction.values, contains(AccountAction.exportData));
      expect(AccountAction.values, contains(AccountAction.deleteAccount));
    });
  });

  group('ConsentsCubit Tests', () {
    late MockAccountRepo mockRepo;
    late ConsentsCubit cubit;

    setUp(() {
      mockRepo = MockAccountRepo();
      cubit = ConsentsCubit(accountRepo: mockRepo);
    });

    tearDown(() => cubit.close());

    test('61. Initial state is ConsentsInitial', () {
      expect(cubit.state, const ConsentsState.initial());
    });

    test('62. load emits [loading, success]', () async {
      const model = ConsentsModel();
      when(() => mockRepo.getConsents()).thenAnswer((_) async => const ApiResult.success(model));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ConsentsState.loading(),
          const ConsentsState.success(model),
        ]),
      );

      await cubit.load();
    });

    test('63. load emits [loading, error] on failure', () async {
      when(() => mockRepo.getConsents()).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.consents_error')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const ConsentsState.loading(),
          const ConsentsState.error('errors.consents_error'),
        ]),
      );

      await cubit.load();
    });

    test('64. set does nothing if state is not ConsentsSuccess', () async {
      await cubit.set(ConsentType.notifications, granted: true);
      verifyNever(() => mockRepo.recordConsent(any(), granted: any(named: 'granted')));
    });

    test('65. set updates optimistically then emits server response on success', () async {
      final initialConsents = ConsentsModel(
        current: [
          ConsentModel(type: 'Notifications', granted: false, recordedAtUtc: DateTime.utc(2026, 1, 1)),
        ],
      );
      when(() => mockRepo.getConsents()).thenAnswer((_) async => ApiResult.success(initialConsents));
      await cubit.load();

      final updatedConsents = ConsentsModel(
        current: [
          ConsentModel(type: 'Notifications', granted: true, recordedAtUtc: DateTime.utc(2026, 1, 2)),
        ],
      );
      when(() => mockRepo.recordConsent(ConsentType.notifications, granted: true))
          .thenAnswer((_) async => ApiResult.success(updatedConsents));

      await cubit.set(ConsentType.notifications, granted: true);

      final state = cubit.state as ConsentsSuccess;
      expect(state.consents.isGranted('Notifications'), isTrue);
      expect(state.failure, isNull);
    });

    test('66. set rolls back on failure with error message', () async {
      final initialConsents = ConsentsModel(
        current: [
          ConsentModel(type: 'Notifications', granted: false, recordedAtUtc: DateTime.utc(2026, 1, 1)),
        ],
      );
      when(() => mockRepo.getConsents()).thenAnswer((_) async => ApiResult.success(initialConsents));
      await cubit.load();

      when(() => mockRepo.recordConsent(ConsentType.notifications, granted: true)).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.record_consent_failed')),
      );

      await cubit.set(ConsentType.notifications, granted: true);

      final state = cubit.state as ConsentsSuccess;
      expect(state.consents.isGranted('Notifications'), isFalse);
      expect(state.failure, 'errors.record_consent_failed');
    });

    test('67. ConsentsCubit safe when closed mid-operation', () async {
      when(() => mockRepo.getConsents()).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return const ApiResult.success(ConsentsModel());
      });

      final f = cubit.load();
      await cubit.close();
      await f;
      expect(cubit.isClosed, isTrue);
    });

    test('68. set handles multiple different consent types independently', () async {
      const initial = ConsentsModel();
      when(() => mockRepo.getConsents()).thenAnswer((_) async => const ApiResult.success(initial));
      await cubit.load();

      when(() => mockRepo.recordConsent(ConsentType.location, granted: true))
          .thenAnswer((_) async => const ApiResult.success(ConsentsModel()));

      await cubit.set(ConsentType.location, granted: true);
      verify(() => mockRepo.recordConsent(ConsentType.location, granted: true)).called(1);
    });
  });

  group('SessionsCubit Tests', () {
    late MockAccountRepo mockRepo;
    late SessionsCubit cubit;

    setUp(() {
      mockRepo = MockAccountRepo();
      cubit = SessionsCubit(accountRepo: mockRepo);
    });

    tearDown(() => cubit.close());

    test('69. Initial state is SessionsInitial', () {
      expect(cubit.state, const SessionsState.initial());
    });

    test('70. load emits [loading, success] with current session placed first', () async {
      final s1 = _makeSession(id: 's1', isCurrent: false, lastActivityAt: DateTime.utc(2026, 1, 10));
      final sCurrent = _makeSession(id: 'sCurrent', isCurrent: true, lastActivityAt: DateTime.utc(2026, 1, 5));
      final s2 = _makeSession(id: 's2', isCurrent: false, lastActivityAt: DateTime.utc(2026, 1, 8));

      when(() => mockRepo.getSessions()).thenAnswer((_) async => ApiResult.success([s1, sCurrent, s2]));

      await cubit.load();

      final state = cubit.state as SessionsSuccess;
      expect(state.sessions.first.sessionId, 'sCurrent');
      expect(state.sessions[1].sessionId, 's1'); // most recent among non-current
      expect(state.sessions[2].sessionId, 's2');
    });

    test('71. load emits [loading, error] on failure', () async {
      when(() => mockRepo.getSessions()).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.sessions_failed')),
      );

      expectLater(
        cubit.stream,
        emitsInOrder([
          const SessionsState.loading(),
          const SessionsState.error('errors.sessions_failed'),
        ]),
      );

      await cubit.load();
    });

    test('72. load does not emit loading state if state is already SessionsSuccess', () async {
      when(() => mockRepo.getSessions()).thenAnswer((_) async => const ApiResult.success([]));
      await cubit.load();

      var emittedLoading = false;
      final sub = cubit.stream.listen((s) {
        if (s is SessionsLoading) emittedLoading = true;
      });

      await cubit.load();
      await sub.cancel();
      expect(emittedLoading, isFalse);
    });

    test('73. revoke ignores call when state is not SessionsSuccess', () async {
      await cubit.revoke('s1');
      verifyNever(() => mockRepo.revokeSession(any()));
    });

    test('74. revoke sets busy=true then reloads sessions on success', () async {
      when(() => mockRepo.getSessions()).thenAnswer((_) async => const ApiResult.success([]));
      await cubit.load();

      when(() => mockRepo.revokeSession('s1')).thenAnswer((_) async => const ApiResult.success(null));

      await cubit.revoke('s1');
      verify(() => mockRepo.revokeSession('s1')).called(1);
      verify(() => mockRepo.getSessions()).called(2);
    });

    test('75. revoke emits failure and busy=false on error', () async {
      when(() => mockRepo.getSessions()).thenAnswer((_) async => const ApiResult.success([]));
      await cubit.load();

      when(() => mockRepo.revokeSession('s1')).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.revoke_failed')),
      );

      await cubit.revoke('s1');

      final state = cubit.state as SessionsSuccess;
      expect(state.busy, isFalse);
      expect(state.failure, 'errors.revoke_failed');
    });

    test('76. revokeOtherSessions delegates to repo and reloads', () async {
      when(() => mockRepo.getSessions()).thenAnswer((_) async => const ApiResult.success([]));
      await cubit.load();

      when(() => mockRepo.revokeOtherSessions()).thenAnswer((_) async => const ApiResult.success(null));

      await cubit.revokeOthers();
      verify(() => mockRepo.revokeOtherSessions()).called(1);
    });

    test('77. revokeOthers emits failure when repo fails', () async {
      when(() => mockRepo.getSessions()).thenAnswer((_) async => const ApiResult.success([]));
      await cubit.load();

      when(() => mockRepo.revokeOtherSessions()).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.revoke_others_failed')),
      );

      await cubit.revokeOthers();

      final state = cubit.state as SessionsSuccess;
      expect(state.busy, isFalse);
      expect(state.failure, 'errors.revoke_others_failed');
    });

    test('78. revoke is ignored when already busy', () async {
      when(() => mockRepo.getSessions()).thenAnswer((_) async => const ApiResult.success([]));
      await cubit.load();

      when(() => mockRepo.revokeSession('s1')).thenAnswer((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        return const ApiResult.success(null);
      });

      final f1 = cubit.revoke('s1');
      final f2 = cubit.revoke('s1');
      await Future.wait([f1, f2]);

      verify(() => mockRepo.revokeSession('s1')).called(1);
    });
  });

  group('BiometricLockCubit & NotificationPreferences Additional Tests', () {
    late MockBiometricLock lock;
    late BiometricLockCubit biometricCubit;
    late MockNotificationsRepo notifRepo;
    late NotificationPreferencesCubit notifCubit;

    setUp(() {
      lock = MockBiometricLock();
      biometricCubit = BiometricLockCubit(biometricLock: lock);
      notifRepo = MockNotificationsRepo();
      notifCubit = NotificationPreferencesCubit(notificationsRepo: notifRepo);
    });

    tearDown(() {
      biometricCubit.close();
      notifCubit.close();
    });

    test('79. BiometricLockCubit initial state is loading', () {
      expect(biometricCubit.state, const BiometricLockState.loading());
    });

    test('80. BiometricLockCubit load emits unavailable when not available', () async {
      when(() => lock.isAvailable()).thenAnswer((_) async => false);

      await biometricCubit.load();
      expect(biometricCubit.state, const BiometricLockState.unavailable());
    });

    test('81. BiometricLockCubit load emits ready with enabled status', () async {
      when(() => lock.isAvailable()).thenAnswer((_) async => true);
      when(() => lock.isEnabled()).thenAnswer((_) async => true);

      await biometricCubit.load();
      expect(biometricCubit.state, const BiometricLockState.ready(enabled: true));
    });

    test('82. setEnabled disables lock without calling authenticate', () async {
      when(() => lock.isAvailable()).thenAnswer((_) async => true);
      when(() => lock.isEnabled()).thenAnswer((_) async => true);
      when(() => lock.setEnabled(enabled: false)).thenAnswer((_) async {});

      await biometricCubit.load();
      await biometricCubit.setEnabled(enabled: false, reason: 'Turn off');

      verifyNever(() => lock.authenticate(any()));
      verify(() => lock.setEnabled(enabled: false)).called(1);
      expect(biometricCubit.state, const BiometricLockState.ready(enabled: false));
    });

    test('83. setEnabled does nothing if state is not BiometricLockReady', () async {
      await biometricCubit.setEnabled(enabled: true, reason: 'r');
      verifyNever(() => lock.authenticate(any()));
      verifyNever(() => lock.setEnabled(enabled: any(named: 'enabled')));
    });

    test('84. NotificationPreferencesCubit initial state is initial', () {
      expect(notifCubit.state, const NotificationPreferencesState.initial());
    });

    test('85. NotificationPreferencesCubit load emits [loading, error] on failure', () async {
      when(() => notifRepo.getPreferences()).thenAnswer(
        (_) async => const ApiResult.failure(AppApiFailure(message: 'errors.notif_pref_failed')),
      );

      expectLater(
        notifCubit.stream,
        emitsInOrder([
          const NotificationPreferencesState.loading(),
          const NotificationPreferencesState.error('errors.notif_pref_failed'),
        ]),
      );

      await notifCubit.load();
    });

    test('86. toggle does nothing if category is not found in state', () async {
      when(() => notifRepo.getPreferences()).thenAnswer((_) async => const ApiResult.success([]));
      await notifCubit.load();

      await notifCubit.toggle('UnknownCategory', enabled: true);
      verifyNever(() => notifRepo.updatePreference(any(), inAppEnabled: any(named: 'inAppEnabled'), pushEnabled: any(named: 'pushEnabled')));
    });
  });

  group('Settings States Equatable & Freezed Representation Tests', () {
    test('87. AccountActionState loading equality check', () {
      const s1 = AccountActionState.loading(AccountAction.changeLanguage);
      const s2 = AccountActionState.loading(AccountAction.changeLanguage);
      expect(s1, equals(s2));
    });

    test('88. AccountActionState languageChanged equality check', () {
      const s1 = AccountActionState.languageChanged('ar');
      const s2 = AccountActionState.languageChanged('ar');
      expect(s1, equals(s2));
    });

    test('89. ConsentsState initial equality check', () {
      const s1 = ConsentsState.initial();
      const s2 = ConsentsState.initial();
      expect(s1, equals(s2));
    });

    test('90. ConsentsState loading equality check', () {
      const s1 = ConsentsState.loading();
      const s2 = ConsentsState.loading();
      expect(s1, equals(s2));
    });

    test('91. SessionsState initial equality check', () {
      const s1 = SessionsState.initial();
      const s2 = SessionsState.initial();
      expect(s1, equals(s2));
    });

    test('92. SessionsState loading equality check', () {
      const s1 = SessionsState.loading();
      const s2 = SessionsState.loading();
      expect(s1, equals(s2));
    });

    test('93. NotificationPreferencesState initial equality check', () {
      const s1 = NotificationPreferencesState.initial();
      const s2 = NotificationPreferencesState.initial();
      expect(s1, equals(s2));
    });

    test('94. NotificationPreferencesState loading equality check', () {
      const s1 = NotificationPreferencesState.loading();
      const s2 = NotificationPreferencesState.loading();
      expect(s1, equals(s2));
    });

    test('95. BiometricLockState ready equality check', () {
      const s1 = BiometricLockState.ready(enabled: true);
      const s2 = BiometricLockState.ready(enabled: true);
      expect(s1, equals(s2));
    });
  });
}
