import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/radio_option_card_widget.dart';
import '../../../explore/data/models/venue_payment_method_model.dart';
import '../../data/models/create_booking_response_model.dart';
import '../widgets/deposit_step_widget.dart';
import '../widgets/deposit_summary_card_widget.dart';
import '../widgets/deposit_timer_banner_widget.dart';
import '../widgets/deposit_wallet_card_widget.dart';

class DepositInstructionsScreen extends HookWidget {
  const DepositInstructionsScreen({this.arguments, super.key});

  final Map<String, dynamic>? arguments;

  String _formatSlot(String? startUtc, String? endUtc) {
    if (startUtc == null || endUtc == null) return '';
    try {
      final start = DateTime.parse(startUtc).toLocal();
      final end = DateTime.parse(endUtc).toLocal();
      final dateStr = DateFormat('EEEE d MMMM', 'ar').format(start);
      final startTime = DateFormat('h:mm a', 'ar').format(start);
      final endTime = DateFormat('h:mm a', 'ar').format(end);
      return '$dateStr • $startTime - $endTime';
    } catch (_) {
      return '';
    }
  }

  String _calculateRemaining(DateTime? expiresAt) {
    if (expiresAt == null) return '١٤:٥٩';
    final now = DateTime.now();
    final diff = expiresAt.difference(now);
    if (diff.isNegative) return '٠٠:٠٠';
    final minutes = diff.inMinutes;
    final seconds = diff.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final booking = arguments?['booking'] as CreateBookingResponseModel?;
    final methods =
        arguments?['paymentMethods'] as List<VenuePaymentMethodModel>? ?? [];

    final selectedMethodIndex = useState(0);

    final expiresAt = useMemoized(() {
      if (booking?.holdExpiresAtUtc == null) return null;
      return DateTime.tryParse(booking!.holdExpiresAtUtc)?.toLocal();
    }, [booking?.holdExpiresAtUtc]);

    final remainingTime = useState(_calculateRemaining(expiresAt));

    useEffect(() {
      if (expiresAt == null) return null;
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        remainingTime.value = _calculateRemaining(expiresAt);
      });
      return timer.cancel;
    }, [expiresAt]);

    final slotLabel = _formatSlot(booking?.startUtc, booking?.endUtc);
    final totalPrice = booking?.totalPrice;
    final depositAmount = booking?.depositAmount;
    final remainingPrice = (totalPrice != null && depositAmount != null)
        ? (totalPrice - depositAmount)
        : null;

    final hasBackendMethods = methods.isNotEmpty;
    final activeMethod =
        hasBackendMethods && selectedMethodIndex.value < methods.length
        ? methods[selectedMethodIndex.value]
        : null;

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.deposit.title'.tr(context: context),
      ),
      bottomNavigationBar: BottomActionBarWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: 'booking.deposit.cta'.tr(context: context),
              height: 52.h,
              borderRadius: 16,
              boxShadow: AppShadows.redGlow,
              icon: SvgPicture.asset(
                AppAssets.icUploadWhite,
                width: 20.r,
                height: 20.r,
              ),
              textStyle: AppTextStyles.font16Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: () => Navigator.of(context).pushNamed(
                AppRoutes.uploadProof,
                arguments: {
                  'booking': booking,
                  'bookingId': booking?.bookingId,
                  'depositAmount': booking?.depositAmount,
                },
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
              onTap: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        children: [
          DepositTimerBannerWidget(remaining: remainingTime.value),
          hSpace(12),
          DepositSummaryCardWidget(
            bookingReference: booking?.bookingReference,
            slotLabel: slotLabel.isNotEmpty ? slotLabel : null,
            totalPrice: totalPrice,
            depositAmount: depositAmount,
            remainingPrice: remainingPrice,
            currency: booking?.currency ?? 'ج.م',
          ),
          hSpace(12),
          Text(
            'booking.deposit.choose_method'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(12),
          if (hasBackendMethods) ...[
            for (var i = 0; i < methods.length; i++) ...[
              RadioOptionCardWidget(
                title: methods[i].methodType == 'MobileWallet'
                    ? 'فودافون كاش ومحافظ المحمول'
                    : methods[i].methodType == 'InstaPay'
                    ? 'إنستاباي (InstaPay)'
                    : methods[i].methodType,
                subtitle: methods[i].recipientName.isNotEmpty
                    ? '${methods[i].accountDetailsMasked} • ${methods[i].recipientName}'
                    : methods[i].accountDetailsMasked,
                isSelected: selectedMethodIndex.value == i,
                onTap: () => selectedMethodIndex.value = i,
              ),
              if (i < methods.length - 1) hSpace(8),
            ],
          ] else ...[
            RadioOptionCardWidget(
              title: 'booking.deposit.vodafone'.tr(context: context),
              subtitle: 'booking.deposit.vodafone_sub'.tr(context: context),
              isSelected: selectedMethodIndex.value == 0,
              onTap: () => selectedMethodIndex.value = 0,
            ),
            hSpace(8),
            RadioOptionCardWidget(
              title: 'booking.deposit.instapay'.tr(context: context),
              subtitle: 'booking.deposit.instapay_sub'.tr(context: context),
              isSelected: selectedMethodIndex.value == 1,
              onTap: () => selectedMethodIndex.value = 1,
            ),
          ],
          hSpace(12),
          DepositWalletCardWidget(
            accountNumber: activeMethod != null
                ? activeMethod.accountDetailsMasked
                : (selectedMethodIndex.value == 0
                      ? '01012342345'
                      : 'mal3abk@instapay'),
            recipientName: activeMethod?.recipientName,
            bookingNo: booking?.bookingReference,
            instructions: activeMethod?.instructions,
            label: activeMethod?.methodType == 'InstaPay'
                ? 'معرف إنستاباي (IPA)'
                : 'رقم المحفظة',
          ),
          hSpace(12),
          Text(
            'booking.deposit.steps'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(14),
          for (final (number, key) in const [
            ('١', 'step1'),
            ('٢', 'step2'),
            ('٣', 'step3'),
          ]) ...[
            DepositStepWidget(
              number: number,
              text: 'booking.deposit.$key'.tr(context: context),
            ),
            hSpace(10),
          ],
        ],
      ),
    );
  }
}
