import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Rebuilds every second with the time left until [expiresAtUtc] (never
/// negative), measured against the server's UTC deadline rather than the
/// device's time zone.
class HoldCountdownBuilder extends HookWidget {
  const HoldCountdownBuilder({
    required this.expiresAtUtc,
    required this.builder,
    super.key,
    this.onExpired,
  });

  final DateTime expiresAtUtc;
  final Widget Function(BuildContext context, Duration remaining) builder;
  final VoidCallback? onExpired;

  static Duration _left(DateTime expiresAtUtc) {
    final left = expiresAtUtc.toUtc().difference(DateTime.now().toUtc());
    return left.isNegative ? Duration.zero : left;
  }

  /// "١٤:٥٩" in Arabic, "14:59" otherwise.
  static String format(Duration remaining, String languageCode) {
    final text =
        '${remaining.inMinutes.toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}';
    if (languageCode != 'ar') return text;
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return text.replaceAllMapped(
      RegExp(r'\d'),
      (m) => arabic[int.parse(m.group(0)!)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final remaining = useState(_left(expiresAtUtc));
    useEffect(() {
      remaining.value = _left(expiresAtUtc);
      if (remaining.value == Duration.zero) return null;
      final timer = Timer.periodic(const Duration(seconds: 1), (t) {
        remaining.value = _left(expiresAtUtc);
        if (remaining.value == Duration.zero) {
          t.cancel();
          onExpired?.call();
        }
      });
      return timer.cancel;
    }, [expiresAtUtc]);
    return builder(context, remaining.value);
  }
}
