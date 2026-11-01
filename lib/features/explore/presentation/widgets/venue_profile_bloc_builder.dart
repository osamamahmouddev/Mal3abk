import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../../core/widgets/info_note_card_widget.dart';
import '../cubit/venue_profile_cubit.dart';
import '../cubit/venue_profile_state.dart';
import 'venue_hero_widget.dart';
import 'venue_info_header_widget.dart';
import 'venue_pitch_option_card_widget.dart';
import 'venue_price_footer_widget.dart';

class VenueProfileBlocBuilder extends StatelessWidget {
  const VenueProfileBlocBuilder({
    required this.selectedTab,
    required this.onTabSelected,
    super.key,
  });

  final int selectedTab;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VenueProfileCubit, VenueProfileState>(
      builder: (context, state) {
        return switch (state) {
          VenueProfileLoading() => const Scaffold(
            backgroundColor: AppColors.pageBackground,
            body: Center(child: CircularProgressIndicator.adaptive()),
          ),
          VenueProfileSuccess(:final venue, :final pitches) => Scaffold(
            backgroundColor: AppColors.pageBackground,
            bottomNavigationBar: VenuePriceFooterWidget(
              price: venue.fromHourlyPrice != null
                  ? '${venue.fromHourlyPrice!.toInt()} ${venue.currency}'
                  : null,
              onTap: () => Navigator.of(
                context,
              ).pushNamed(AppRoutes.pitchAndTime, arguments: venue.venueId),
            ),
            body: ListView(
              padding: EdgeInsets.only(bottom: 16.h),
              children: [
                VenueHeroWidget(
                  photoCount: venue.photos.isNotEmpty ? venue.photos.length : 1,
                ),
                VenueInfoHeaderWidget(
                  name: venue.name,
                  address: '${venue.address}، ${venue.area}',
                  rating: '4.8',
                ),
                CustomTabBarWidget(
                  tabs: [
                    'explore.venue.tab_pitches'.tr(context: context),
                    'explore.venue.tab_amenities'.tr(context: context),
                    'explore.venue.tab_policies'.tr(context: context),
                  ],
                  selectedIndex: selectedTab,
                  onTabSelected: onTabSelected,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                  child: switch (selectedTab) {
                    0 => _PitchesTabContent(
                      pitches: pitches,
                      venueId: venue.venueId,
                    ),
                    1 => _AmenitiesTabContent(facilities: venue.facilities),
                    2 => _PoliciesTabContent(venue: venue),
                    _ => const SizedBox.shrink(),
                  },
                ),
              ],
            ),
          ),
          VenueProfileError(:final message) => Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: AppBar(title: const Text('ملعبك')),
            body: Center(
              child: Text(
                message,
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.redText,
                ),
              ),
            ),
          ),
          _ => const Scaffold(
            backgroundColor: AppColors.pageBackground,
            body: Center(child: CircularProgressIndicator.adaptive()),
          ),
        };
      },
    );
  }
}

class _PitchesTabContent extends StatelessWidget {
  const _PitchesTabContent({required this.pitches, required this.venueId});

  final List<dynamic> pitches;
  final String venueId;

  @override
  Widget build(BuildContext context) {
    if (pitches.isEmpty) {
      return Column(
        children: [
          VenuePitchOptionCardWidget(
            title: 'الملعب الرئيسي',
            subtitle: 'خماسي · نجيل صناعي معتمد',
            price: '200 ج.م',
            onTap: () => Navigator.of(
              context,
            ).pushNamed(AppRoutes.pitchAndTime, arguments: venueId),
          ),
          hSpace(12),
          InfoNoteCardWidget(
            title: 'explore.venue.payment_title'.tr(context: context),
            body: 'explore.venue.payment_body'.tr(context: context),
          ),
        ],
      );
    }

    return Column(
      children: [
        for (final pitch in pitches) ...[
          VenuePitchOptionCardWidget(
            title: pitch.name,
            subtitle:
                '${pitch.pitchType} · ${pitch.surface.nameAr} · ${pitch.playersPerTeam * 2} لاعبين',
            price: pitch.baseHourlyPrice != null
                ? '${pitch.baseHourlyPrice.toInt()} ${pitch.currency}'
                : '200 ج.م',
            onTap: () => Navigator.of(
              context,
            ).pushNamed(AppRoutes.pitchAndTime, arguments: venueId),
          ),
          hSpace(12),
        ],
        InfoNoteCardWidget(
          title: 'explore.venue.payment_title'.tr(context: context),
          body: 'explore.venue.payment_body'.tr(context: context),
        ),
      ],
    );
  }
}

class _AmenitiesTabContent extends StatelessWidget {
  const _AmenitiesTabContent({required this.facilities});

  final List<dynamic> facilities;

  @override
  Widget build(BuildContext context) {
    if (facilities.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Text(
            'لا توجد مميزات مضافة حالياً',
            style: AppTextStyles.font14Regular,
          ),
        ),
      );
    }

    return Column(
      children: [
        for (final item in facilities) ...[
          CustomCardWidget(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: AppColors.pitchGreenDark,
                  size: 20.r,
                ),
                vSpace(12),
                Expanded(
                  child: Text(
                    item.nameAr ?? item.code,
                    style: AppTextStyles.font14SemiBold,
                  ),
                ),
              ],
            ),
          ),
          hSpace(8),
        ],
      ],
    );
  }
}

class _PoliciesTabContent extends StatelessWidget {
  const _PoliciesTabContent({required this.venue});

  final dynamic venue;

  @override
  Widget build(BuildContext context) {
    final policy = venue.depositPolicy;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomCardWidget(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('شروط الحجز والإلغاء', style: AppTextStyles.font16Bold),
              vSpace(10),
              if (policy != null) ...[
                Text(
                  '• نسبة العربون: ${policy.depositValue}% من إجمالي الحجز',
                  style: AppTextStyles.font13Regular,
                ),
                vSpace(6),
                Text(
                  '• مهلة رفع الإيصال: ${policy.proofSubmissionWindowMinutes} دقيقة',
                  style: AppTextStyles.font13Regular,
                ),
                vSpace(6),
                Text(
                  '• مهلة الإلغاء واسترداد العربون: قبل الموعد بـ ${policy.cancellationDeadlineHours} ساعة',
                  style: AppTextStyles.font13Regular,
                ),
                vSpace(6),
                Text(
                  '• فترة السماح بالتأخير: ${policy.lateArrivalGraceMinutes} دقيقة',
                  style: AppTextStyles.font13Regular,
                ),
              ] else ...[
                Text(
                  '• تطبق السياسات القياسية للملعب',
                  style: AppTextStyles.font13Regular,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
