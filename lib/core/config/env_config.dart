abstract class EnvConfig {
  String get baseUrl;
  String get envName;
  bool get isDebug;
}

class DevEnvConfig implements EnvConfig {
  const DevEnvConfig();

  @override
  String get baseUrl => 'https://api.dev.mal3abk.com';

  @override
  String get envName => 'dev';

  @override
  bool get isDebug => true;
}

class ProdEnvConfig implements EnvConfig {
  const ProdEnvConfig();

  @override
  String get baseUrl => 'https://api.mal3abk.com';

  @override
  String get envName => 'prod';

  @override
  bool get isDebug => false;
}
