import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/icon_note_widget.dart';
import '../../../explore/presentation/cubit/pitch_booking_cubit.dart';
import '../../../explore/presentation/cubit/pitch_booking_state.dart';
import 'booking_detail_row_widget.dart';
import 'booking_policy_card_widget.dart';
import 'booking_type_selector_widget.dart';

class BookingReviewBlocBuilder extends StatelessWidget {
  const BookingReviewBlocBuilder({
    required this.isTeamBooking,
    required this.agreedToPolicy,
    required this.onTeamBookingChanged,
    required this.onAgreedChanged,
    super.key,
  });

  final bool isTeamBooking;
  final bool agreedToPolicy;
  final ValueChanged<bool> onTeamBookingChanged;
  final ValueChanged<bool> onAgreedChanged;

  String _formatSlotTime(String localIso) {
    try {
      final dt = DateTime.parse(localIso);
      final hour = dt.hour;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'م' : 'ص';
      final formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$formattedHour:$minute $period';
    } catch (_) {
      return localIso;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PitchBookingCubit, PitchBookingState>(
      listener: (context, state) {
        if (state is PitchBookingLoaded) {
          if (state.bookingError != null) {
            AppTopSnackBar.showError(context, state.bookingError!);
          } else if (state.createdBooking != null) {
            Navigator.of(context).pushReplacementNamed(
              AppRoutes.depositInstructions,
              arguments: state.createdBooking,
            );
          }
        }
      },
      builder: (context, state) {
        if (state is! PitchBookingLoaded) {
          return const Scaffold(
            backgroundColor: AppColors.pageBackground,
            appBar: CustomAppBarWidget(title: 'مراجعة الحجز'),
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }

        final pitch = state.currentPitch;
        final slot = state.selectedSlot;
        final quote = state.quote;

        final startLabel = slot != null ? _formatSlotTime(slot.startLocal) : '';
        final endLabel = slot != null ? _formatSlotTime(slot.endLocal) : '';

        return Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: CustomAppBarWidget(
            title: 'booking.review_title'.tr(context: context),
          ),
          bottomNavigationBar: BottomActionBarWidget(
            child: CustomButton(
              text: 'booking.submit_request'.tr(context: context),
              height: 52.h,
              borderRadius: 16,
              isLoading: state.isBooking,
              backgroundColor: agreedToPolicy
                  ? AppColors.brandRed
                  : AppColors.border,
              boxShadow: agreedToPolicy ? AppShadows.redGlow : null,
              textStyle: AppTextStyles.font16Bold.copyWith(
                color: agreedToPolicy ? AppColors.white : AppColors.mapLabel,
              ),
              onTap: () {
                if (!agreedToPolicy) {
                  AppTopSnackBar.showError(
                    context,
                    'booking.agree_policy_required'.tr(context: context),
                  );
                  return;
                }

                context.read<PitchBookingCubit>().createBookingHold(
                  customerName: 'أحمد سامي',
                  customerPhone: '+201012345678',
                );
              },
            ),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
            children: [
              BookingTypeSelectorWidget(
                isTeamBooking: isTeamBooking,
                onChanged: onTeamBookingChanged,
              ),
              hSpace(14),
              // Match info card
              CustomCardWidget(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      pitch?.name ?? 'الملعب الرئيسي',
                      style: AppTextStyles.font16Bold,
                    ),
                    hSpace(12),
                    BookingDetailRowWidget(
                      label: 'الميعاد',
                      value: '$startLabel - $endLabel',
                    ),
                    BookingDetailRowWidget(
                      label: 'الملعب',
                      value: '${pitch?.slotMinutes ?? 60} دقيقة',
                    ),
                    const BookingDetailRowWidget(
                      label: 'المسؤول عن الحجز',
                      value: 'أحمد سامي • 01012345678',
                    ),
                  ],
                ),
              ),
              hSpace(14),
              // Price summary card
              CustomCardWidget(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('ملخص السعر', style: AppTextStyles.font16Bold),
                    hSpace(14),
                    BookingDetailRowWidget(
                      label: 'سعر الحجز',
                      value: quote != null
                          ? '${quote.total.toInt()} ${state.availability.currency}'
                          : '${slot?.price?.toInt() ?? 200} ${state.availability.currency}',
                    ),
                    const BookingDetailRowWidget(
                      label: 'رسوم الخدمة',
                      value: '0 ج.م',
                    ),
                    hSpace(8),
                    Container(height: 1, color: AppColors.border),
                    hSpace(8),
                    BookingDetailRowWidget(
                      label: 'الإجمالي',
                      value: quote != null
                          ? '${quote.total.toInt()} ${state.availability.currency}'
                          : '200 ج.م',
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
                              'العربون المطلوب الآن',
                              style: AppTextStyles.font14SemiBold.copyWith(
                                color: AppColors.goldDark,
                              ),
                            ),
                          ),
                          Text(
                            quote != null
                                ? '${quote.deposit.toInt()} ${state.availability.currency}'
                                : '50 ج.م',
                            style: AppTextStyles.font16Bold.copyWith(
                              color: AppColors.goldDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    hSpace(8),
                    BookingDetailRowWidget(
                      label: 'المتبقي — يُدفع في الملعب',
                      value: quote != null
                          ? '${quote.remainingBalance.toInt()} ${state.availability.currency}'
                          : '150 ج.م',
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
            ],
          ),
        );
      },
    );
  }
}
