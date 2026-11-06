import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/hold_countdown_builder.dart';
import 'deposit_timer_banner_widget.dart';

/// The deposit deadline counting down from the server's hold expiry.
class HoldTimerBannerWidget extends StatelessWidget {
  const HoldTimerBannerWidget({
    required this.expiresAtUtc,
    super.key,
    this.onExpired,
  });

  final DateTime expiresAtUtc;
  final VoidCallback? onExpired;

  @override
  Widget build(BuildContext context) {
    return HoldCountdownBuilder(
      expiresAtUtc: expiresAtUtc,
      onExpired: onExpired,
      builder: (context, remaining) => DepositTimerBannerWidget(
        remaining: HoldCountdownBuilder.format(
          remaining,
          context.locale.languageCode,
        ),
      ),
    );
  }
}
