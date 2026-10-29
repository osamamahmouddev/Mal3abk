import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/recover_phone_bloc_builder.dart';

/// Opened from the recovery link texted to the old phone:
/// `https://malabak.app/recover-phone?token=…`.
class RecoverPhoneScreen extends StatelessWidget {
  const RecoverPhoneScreen({required this.recoveryToken, super.key});

  final String recoveryToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'phone_change.recover.title'.tr(context: context),
        showBackButton: false,
      ),
      body: SafeArea(
        child: RecoverPhoneBlocBuilder(recoveryToken: recoveryToken),
      ),
    );
  }
}
