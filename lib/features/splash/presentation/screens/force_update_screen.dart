import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({
    super.key,
    this.storeUrlOverride,
  });

  final String? storeUrlOverride;

  static const String _playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.malabak.app';
  static const String _appStoreUrl =
      'https://apps.apple.com/app/id6470000000';

  Future<void> _openStore() async {
    final urlString = storeUrlOverride ??
        (Platform.isIOS ? _appStoreUrl : _playStoreUrl);
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.brandNavy,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  AppAssets.iconMark1024,
                  width: 120.r,
                  height: 120.r,
                ),
                hSpace(24),
                Text(
                  'force_update.title'.tr(context: context),
                  style: AppTextStyles.font22Bold.copyWith(
                    color: AppColors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                hSpace(12),
                Text(
                  'force_update.description'.tr(context: context),
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.onNavyMuted,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                CustomButton(
                  text: 'force_update.cta'.tr(context: context),
                  height: 52.h,
                  borderRadius: 16,
                  boxShadow: AppShadows.redGlow,
                  textStyle: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.white,
                  ),
                  onTap: _openStore,
                ),
                hSpace(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
