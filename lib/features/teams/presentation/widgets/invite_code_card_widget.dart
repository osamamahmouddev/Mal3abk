import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/routes/invite_link.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_button.dart';

class InviteCodeCardWidget extends StatelessWidget {
  const InviteCodeCardWidget({required this.code, super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    final link = InviteLink.share(sl<EnvConfig>().baseUrl, code);
    void copy(String text) {
      Clipboard.setData(ClipboardData(text: text));
      AppTopSnackBar.showSuccess(
        context,
        'teams.invite.copied'.tr(context: context),
      );
    }

    final ghostStyle = AppTextStyles.font14SemiBold.copyWith(
      color: AppColors.white,
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.brandNavy,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppAssets.inviteCodePattern,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'teams.invite.share_code'.tr(context: context),
                  style: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
                hSpace(4),
                Row(
                  children: [
                    // The code reads left to right but sits at the start of
                    // the row, under its label, in both languages.
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          code,
                          textDirection: TextDirection.ltr,
                          style: AppTextStyles.font26Bold.copyWith(
                            color: AppColors.accentGold,
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      text: 'teams.invite.copy'.tr(context: context),
                      type: CustomButtonType.outline,
                      height: 40.h,
                      borderRadius: 10,
                      borderColor: AppColors.white35,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      textStyle: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.white,
                      ),
                      onTap: () => copy(code),
                    ),
                  ],
                ),
                hSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'teams.invite.whatsapp'.tr(context: context),
                        height: 44.h,
                        borderRadius: 10,
                        backgroundColor: AppColors.white,
                        icon: SvgPicture.asset(
                          AppAssets.icWhatsapp,
                          width: 18.r,
                          height: 18.r,
                        ),
                        textStyle: AppTextStyles.font14Bold.copyWith(
                          color: AppColors.brandNavy,
                        ),
                        onTap: () => SharePlus.instance.share(
                          ShareParams(
                            text: 'teams.invite.share_message'.tr(
                              context: context,
                              args: [link, code],
                            ),
                          ),
                        ),
                      ),
                    ),
                    vSpace(8),
                    Expanded(
                      child: CustomButton(
                        text: 'teams.invite.copy_link'.tr(context: context),
                        type: CustomButtonType.outline,
                        height: 44.h,
                        borderRadius: 10,
                        borderColor: AppColors.white35,
                        textStyle: ghostStyle,
                        onTap: () => copy(link),
                      ),
                    ),
                  ],
                ),
                hSpace(8),
                Text(
                  'teams.invite.code_note'.tr(context: context),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.onNavySubtle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
