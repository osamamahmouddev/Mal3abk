import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/theme/app_system_ui.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../onboarding/presentation/widgets/profile_setup_position_selector_widget.dart';
import '../../data/models/profile_overview_model.dart';
import '../cubit/profile_cubit.dart';
import 'profile_stat_widget.dart';

class ProfileHeaderCardWidget extends StatelessWidget {
  const ProfileHeaderCardWidget({required this.overview, super.key});

  final ProfileOverviewModel overview;

  @override
  Widget build(BuildContext context) {
    final profile = overview.profile;
    final subtitle = [
      ?profile.area,
      ?profile.city,
      for (final p in profile.playerPositions)
        ProfileSetupPositionSelectorWidget.labelKey(p).tr(context: context),
    ].where((part) => part.isNotEmpty).join(' · ');

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.onDark,
      child: Container(
        color: AppColors.brandNavy,
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                AppAssets.teamHeroPattern,
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 20.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: 'my-avatar',
                          child: CircleAvatar(
                            radius: 36.r,
                            backgroundColor: AppColors.brandRed,
                            foregroundImage: overview.avatarUrl == null
                                ? null
                                : CachedNetworkImageProvider(
                                    overview.avatarUrl!,
                                  ),
                            child: Text(
                              profile.fullName.initials,
                              style: AppTextStyles.font24Bold.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        vSpace(14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile.fullName,
                                style: AppTextStyles.font22Bold.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              if (subtitle.isNotEmpty)
                                Text(
                                  subtitle,
                                  style: AppTextStyles.font13Regular.copyWith(
                                    color: AppColors.onNavyMuted,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        CustomButton(
                          text: 'profile.edit'.tr(context: context),
                          type: CustomButtonType.outline,
                          borderColor: AppColors.white35,
                          borderRadius: 10,
                          height: 40.h,
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          textStyle: AppTextStyles.font14SemiBold.copyWith(
                            color: AppColors.white,
                          ),
                          onTap: () async {
                            final cubit = context.read<ProfileCubit>();
                            final saved = await Navigator.of(context).pushNamed(
                              AppRoutes.profileSetup,
                              arguments: profile,
                            );
                            if (saved != null) await cubit.fetchProfile();
                          },
                        ),
                      ],
                    ),
                    hSpace(16),
                    Row(
                      children: [
                        Expanded(
                          child: ProfileStatWidget(
                            count: overview.matchesPlayed,
                            label: 'profile.matches'.tr(context: context),
                          ),
                        ),
                        vSpace(8),
                        Expanded(
                          child: ProfileStatWidget(
                            count: overview.bookingsCount,
                            label: 'profile.bookings'.tr(context: context),
                          ),
                        ),
                        vSpace(8),
                        Expanded(
                          child: ProfileStatWidget(
                            count: overview.teamsCount,
                            label: 'profile.teams'.tr(context: context),
                            valueColor: AppColors.accentGold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
