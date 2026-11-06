import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
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
    final lang = context.locale.languageCode;
    final profile = overview.profile;
    String count(int? value) => value?.toLocalizedDigits(lang) ?? '—';
    final subtitle = [
      ?profile.area,
      ?profile.city,
      for (final p in profile.playerPositions)
        ProfileSetupPositionSelectorWidget.labelKey(p).tr(context: context),
    ].where((part) => part.isNotEmpty).join(' · ');

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.brandNavy,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Hero(
                tag: 'my-avatar',
                child: CircleAvatar(
                  radius: 36.r,
                  backgroundColor: AppColors.white,
                  foregroundImage: overview.avatarUrl == null
                      ? null
                      : CachedNetworkImageProvider(overview.avatarUrl!),
                  child: Text(
                    profile.fullName.initials,
                    style: AppTextStyles.font22Bold.copyWith(
                      color: AppColors.brandNavy,
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
                      style: AppTextStyles.font20Bold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      hSpace(2),
                      Text(
                        subtitle,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.onNavyMuted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              CustomButton(
                text: 'profile.edit'.tr(context: context),
                type: CustomButtonType.outline,
                borderColor: AppColors.white,
                foregroundColor: AppColors.white,
                borderRadius: 10,
                height: 38.h,
                onTap: () async {
                  final cubit = context.read<ProfileCubit>();
                  final saved = await Navigator.of(
                    context,
                  ).pushNamed(AppRoutes.profileSetup, arguments: profile);
                  if (saved != null) await cubit.fetchProfile();
                },
              ),
            ],
          ),
          hSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileStatWidget(
                value: count(overview.matchesPlayed),
                label: 'profile.matches'.tr(context: context),
              ),
              ProfileStatWidget(
                value: count(overview.teamsCount),
                label: 'profile.teams'.tr(context: context),
              ),
              ProfileStatWidget(
                value: count(overview.bookingsCount),
                label: 'profile.bookings'.tr(context: context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
