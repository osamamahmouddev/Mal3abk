import 'package:flutter/material.dart';

import '../di/service_locator.dart';
import '../security/screen_security.dart';

/// Wraps sensitive screens (e.g. proof upload, payment details, phone change)
/// to enable FLAG_SECURE on Android and privacy protections on iOS while
/// the screen is active, and automatically releases it on disposal.
class SecureScreenWidget extends StatefulWidget {
  const SecureScreenWidget({required this.child, super.key, this.security});

  final Widget child;
  final ScreenSecurity? security;

  @override
  State<SecureScreenWidget> createState() => _SecureScreenWidgetState();
}

class _SecureScreenWidgetState extends State<SecureScreenWidget> {
  late final ScreenSecurity _security;

  @override
  void initState() {
    super.initState();
    _security = widget.security ?? sl<ScreenSecurity>();
    _security.setSecure(true);
  }

  @override
  void dispose() {
    _security.setSecure(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
