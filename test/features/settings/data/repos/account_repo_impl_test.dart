import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/network/api_result.dart';
import 'package:mal3abk/features/settings/data/apis/account_api_service.dart';
import 'package:mal3abk/features/settings/data/repos/account_repo_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../helpers/api_result_matchers.dart';
import '../../../../helpers/dio_errors.dart';

class MockAccountApiService extends Mock implements AccountApiService {}

void main() {
  late MockAccountApiService api;
  late AccountRepoImpl repo;

  setUp(() {
    api = MockAccountApiService();
    repo = AccountRepoImpl(accountApiService: api);
  });

  test('returns the exported document bytes', () async {
    when(() => api.exportData('token')).thenAnswer(
      (_) async => HttpResponse<List<int>>([
        123,
        125,
      ], Response(requestOptions: RequestOptions(), statusCode: 200)),
    );

    final result = await repo.exportData(stepUpToken: 'token');

    expect((result as Success).data, [123, 125]);
  });

  test('maps an expired step-up token', () async {
    when(
      () => api.deleteAccount('old'),
    ).thenThrow(badResponse(401, {'title': 'Identity.InvalidStepUpToken'}));

    expect(
      await repo.deleteAccount(stepUpToken: 'old'),
      isFailureWith('errors.identity.step_up_expired'),
    );
  });
}
