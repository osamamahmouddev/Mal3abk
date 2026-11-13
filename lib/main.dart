import 'core/config/env_config.dart';
import 'main_common.dart';

/// Default entry point (release builds, TestFlight): the production server.
/// Use `main_dev.dart` for the local API.
void main() {
  mainCommon(const ProdEnvConfig());
}
