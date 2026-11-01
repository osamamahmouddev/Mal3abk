class AppConfig {
  const AppConfig._();

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.dev.mal3abk.com',
  );

  static const String env = String.fromEnvironment('ENV', defaultValue: 'dev');

  static bool get isDev => env == 'dev';
  static bool get isProd => env == 'prod';
}
