import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/icon_note_widget.dart';
import '../../../../core/widgets/shimmer_list_skeleton_widget.dart';
import '../../../explore/presentation/cubit/pitch_booking_cubit.dart';
import '../../../explore/presentation/cubit/pitch_booking_state.dart';
import 'booking_detail_row_widget.dart';
import 'booking_policy_card_widget.dart';

class BookingReviewBlocBuilder extends StatelessWidget {
  const BookingReviewBlocBuilder({
    required this.agreedToPolicy,
    required this.onAgreedChanged,
    super.key,
  });

  /// A guest who browsed without signing in gets this when booking.
  static const String unauthorizedKey = 'errors.unauthorized';

  final bool agreedToPolicy;
  final ValueChanged<bool> onAgreedChanged;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    String egp(double value) => 'common.price_egp'.tr(
      context: context,
      args: [value.round().toLocalizedDigits(lang)],
    );
    String t(String key) => 'booking.review.$key'.tr(context: context);

    return BlocConsumer<PitchBookingCubit, PitchBookingState>(
      listener: (context, state) {
        if (state is! PitchBookingLoaded) return;
        if (state.bookingError == unauthorizedKey) {
          AppTopSnackBar.showError(
            context,
            'booking.sign_in_to_book'.tr(context: context),
          );
          Navigator.of(context).pushNamed(AppRoutes.login);
        } else if (state.bookingError case final error?) {
          HapticFeedback.heavyImpact();
          AppTopSnackBar.showError(context, error.tr(context: context));
        } else if (state.createdBooking case final booking?) {
          HapticFeedback.mediumImpact();
          final bookingWithPitch = booking.copyWith(
            pitchName: state.currentPitch?.name,
          );
          Navigator.of(context).pushReplacementNamed(
            AppRoutes.depositInstructions,
            arguments: bookingWithPitch,
          );
        }
      },
      builder: (context, state) {
        final title = 'booking.review_title'.tr(context: context);
        if (state is! PitchBookingLoaded) {
          return Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: CustomAppBarWidget(title: title),
            body: const ShimmerListSkeletonWidget(
              itemHeight: 140,
              itemCount: 3,
            ),
          );
        }
        final pitch = state.currentPitch;
        final slot = state.selectedSlot;
        final quote = state.quote;
        final ready = agreedToPolicy && quote != null && slot != null;

        return Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: CustomAppBarWidget(title: title),
          bottomNavigationBar: BottomActionBarWidget(
            child: CustomButton(
              text: 'booking.submit_request'.tr(context: context),
              height: 52.h,
              borderRadius: 16,
              isLoading: state.isBooking,
              enabled: ready,
              backgroundColor: ready ? AppColors.brandRed : AppColors.border,
              boxShadow: ready ? AppShadows.redGlow : null,
              textStyle: AppTextStyles.font16Bold.copyWith(
                color: ready ? AppColors.white : AppColors.mapLabel,
              ),
              onTap: () {
                if (!agreedToPolicy) {
                  AppTopSnackBar.showError(
                    context,
                    'booking.agree_policy_required'.tr(context: context),
                  );
                  return;
                }
                HapticFeedback.lightImpact();
                context.read<PitchBookingCubit>().createBookingHold();
              },
            ),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
            children: staggeredEntrance([
              CustomCardWidget(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(pitch?.name ?? '', style: AppTextStyles.font16Bold),
                    hSpace(12),
                    if (slot != null)
                      BookingDetailRowWidget(
                        label: t('when'),
                        value:
                            '${CairoTime.dayAndTime(CairoTime.parseUtc(slot.startUtc), lang)} – ${CairoTime.time(CairoTime.parseUtc(slot.endUtc), lang)}',
                      ),
                    if (pitch != null)
                      BookingDetailRowWidget(
                        label: t('duration'),
                        value: 'matches.minutes'.tr(
                          context: context,
                          args: [pitch.slotMinutes.toLocalizedDigits(lang)],
                        ),
                      ),
                  ],
                ),
              ),
              hSpace(14),
              if (quote == null)
                const ShimmerListSkeletonWidget(
                  itemHeight: 180,
                  itemCount: 1,
                  padding: EdgeInsets.zero,
                )
              else
                CustomCardWidget(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(t('price_summary'), style: AppTextStyles.font16Bold),
                      hSpace(14),
                      BookingDetailRowWidget(
                        label: t('subtotal'),
                        value: egp(quote.subtotal),
                      ),
                      if (quote.discount > 0)
                        BookingDetailRowWidget(
                          label: t('discount'),
                          value: '− ${egp(quote.discount)}',
                        ),
                      if (quote.fees > 0)
                        BookingDetailRowWidget(
                          label: t('fees'),
                          value: egp(quote.fees),
                        ),
                      hSpace(8),
                      Container(height: 1, color: AppColors.border),
                      hSpace(8),
                      BookingDetailRowWidget(
                        label: t('total'),
                        value: egp(quote.total),
                        isBold: true,
                      ),
                      hSpace(8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.goldLight,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                t('deposit_now'),
                                style: AppTextStyles.font14SemiBold.copyWith(
                                  color: AppColors.goldDark,
                                ),
                              ),
                            ),
                            Text(
                              egp(quote.deposit),
                              style: AppTextStyles.font16Bold.copyWith(
                                color: AppColors.goldDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      hSpace(8),
                      BookingDetailRowWidget(
                        label: t('at_venue'),
                        value: egp(quote.remainingBalance),
                      ),
                    ],
                  ),
                ),
              hSpace(14),
              IconNoteWidget(
                iconAsset: AppAssets.icClockGold,
                text: 'booking.hold_notice'.tr(context: context),
              ),
              hSpace(14),
              BookingPolicyCardWidget(
                agreedToPolicy: agreedToPolicy,
                onChanged: onAgreedChanged,
              ),
            ]),
          ),
        );
      },
    );
  }
}
