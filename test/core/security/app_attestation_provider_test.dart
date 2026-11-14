import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/core/config/env_config.dart';
import 'package:mal3abk/core/security/app_attestation_provider.dart';

void main() {
  test('returns dev integrity token in debug environment', () async {
    const devEnv = DevEnvConfig();
    const provider = AppAttestationProvider(envConfig: devEnv);

    final token = await provider.getAttestationToken();
    expect(token, equals('dev-app-integrity-token'));
  });

  test(
    'returns null in production until native store attestation is configured',
    () async {
      const prodEnv = ProdEnvConfig();
      const provider = AppAttestationProvider(envConfig: prodEnv);

      final token = await provider.getAttestationToken();
      expect(token, isNull);
    },
  );
}
