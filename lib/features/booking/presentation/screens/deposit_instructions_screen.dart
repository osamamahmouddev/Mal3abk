import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/network/api_result.dart';
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
import '../../../../core/widgets/fade_slide_in_widget.dart';
import '../../../../core/widgets/secure_screen_widget.dart';
import '../../data/models/create_booking_response_model.dart';
import '../../domain/use_cases/pay_booking_commission_use_case.dart';
import '../widgets/deposit_methods_bloc_builder.dart';
import '../widgets/deposit_step_widget.dart';
import '../widgets/deposit_summary_card_widget.dart';
import '../widgets/hold_timer_banner_widget.dart';

class DepositInstructionsScreen extends HookWidget {
  const DepositInstructionsScreen({required this.booking, super.key});

  final CreateBookingResponseModel booking;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final navigator = Navigator.of(context);
    final start = DateTime.parse(booking.startUtc);
    final end = DateTime.parse(booking.endUtc);
    final isPaying = useState(false);

    return SecureScreenWidget(
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'booking.deposit.title'.tr(context: context),
        ),
        bottomNavigationBar: BottomActionBarWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                text: 'booking.pay_with_paymob_btn'.tr(context: context),
                height: 52.h,
                borderRadius: 16,
                isLoading: isPaying.value,
                boxShadow: AppShadows.redGlow,
                textStyle: AppTextStyles.font16Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: () async {
                  isPaying.value = true;
                  final payUseCase = sl<PayBookingCommissionUseCase>();
                  final result = await payUseCase(booking.bookingId);
                  isPaying.value = false;

                  switch (result) {
                    case Success(:final data):
                      final uri = Uri.parse(data.checkoutUrl);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
                        if (context.mounted) {
                          navigator.pushReplacementNamed(
                            AppRoutes.bookingDetails,
                            arguments: booking.bookingId,
                          );
                        }
                      } else {
                        if (context.mounted) {
                          AppTopSnackBar.showError(
                            context,
                            'booking.paymob_launch_error'.tr(context: context),
                          );
                        }
                      }
                    case ApiFailure(:final failure):
                      if (context.mounted) {
                        AppTopSnackBar.showError(
                          context,
                          failure.message.tr(context: context),
                        );
                      }
                  }
                },
              ),
              hSpace(8),
              CustomButton(
                text: 'booking.or_pay_manual'.tr(context: context),
                type: CustomButtonType.outline,
                height: 44.h,
                borderRadius: 14,
                icon: SvgPicture.asset(
                  AppAssets.icUploadWhite,
                  width: 18.r,
                  height: 18.r,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
                textStyle: AppTextStyles.font14SemiBold.copyWith(
                  color: AppColors.textPrimary,
                ),
                onTap: () => navigator.pushReplacementNamed(
                  AppRoutes.uploadProof,
                  arguments: booking.bookingId,
                ),
              ),
              hSpace(8),
              CustomButton(
                text: 'booking.deposit.cancel_request'.tr(context: context),
                type: CustomButtonType.ghost,
                height: 44.h,
                textStyle: AppTextStyles.font14SemiBold.copyWith(
                  color: AppColors.redText,
                ),
                onTap: () async {
                  final cancelled = await navigator.pushNamed(
                    AppRoutes.cancelBooking,
                    arguments: booking.bookingId,
                  );
                  if (cancelled == true) navigator.pop();
                },
              ),
            ],
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(16.r),
          children: [
            FadeSlideInWidget(
              child: HoldTimerBannerWidget(
                expiresAtUtc: DateTime.parse(booking.holdExpiresAtUtc),
              ),
            ),
            hSpace(12),
            FadeSlideInWidget(
              index: 1,
              child: DepositSummaryCardWidget(
                bookingReference: booking.bookingReference,
                pitchName: booking.pitchName,
                slotLabel:
                    '${CairoTime.dayAndTime(start, lang)} – ${CairoTime.time(end, lang)}',
                totalPrice: booking.totalPrice,
                depositAmount: booking.depositAmount,
                platformCommission: booking.platformCommission,
                venuePayAmount: booking.venuePayAmount,
              ),
            ),
            hSpace(12),
            FadeSlideInWidget(
              index: 2,
              child: DepositMethodsBlocBuilder(
                bookingId: booking.bookingId,
                bookingReference: booking.bookingReference,
              ),
            ),
            hSpace(12),
            FadeSlideInWidget(
              index: 3,
              child: Text(
                'booking.deposit.steps'.tr(context: context),
                style: AppTextStyles.font15Bold,
              ),
            ),
            hSpace(14),
            for (final (i, key) in const [
              'step1',
              'step2',
              'step3',
            ].indexed) ...[
              FadeSlideInWidget(
                index: 4 + i,
                child: DepositStepWidget(
                  number: (i + 1).toLocalizedDigits(lang),
                  text: 'booking.deposit.$key'.tr(context: context),
                ),
              ),
              hSpace(10),
            ],
          ],
        ),
      ),
    );
  }
}
