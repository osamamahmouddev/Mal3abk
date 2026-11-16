import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/use_cases/pay_booking_commission_use_case.dart';
import '../cubit/pay_commission_cubit.dart';
import '../cubit/pay_commission_state.dart';

/// The "pay online" button: asks the server for a Paymob checkout page,
/// opens it, then shows the booking, whose status follows the payment.
class PayCommissionBlocConsumer extends StatelessWidget {
  const PayCommissionBlocConsumer({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayCommissionCubit, PayCommissionState>(
      listener: (context, state) async {
        switch (state) {
          case PayCommissionSuccess(:final checkoutUrl):
            final cubit = context.read<PayCommissionCubit>();
            final navigator = Navigator.of(context);
            var opened = false;
            try {
              opened = await launchUrl(
                Uri.parse(checkoutUrl),
                mode: LaunchMode.inAppBrowserView,
              );
            } catch (_) {
              opened = false;
            }
            if (!opened) {
              cubit.launchFailed(
                PayBookingCommissionUseCase.invalidCheckoutKey,
              );
              return;
            }
            if (context.mounted) {
              navigator.pushReplacementNamed(
                AppRoutes.bookingDetails,
                arguments: bookingId,
              );
            }
          case PayCommissionError(:final message):
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      builder: (context, state) => CustomButton(
        text: 'booking.pay_with_paymob_btn'.tr(context: context),
        height: 52.h,
        borderRadius: 16,
        isLoading: state is PayCommissionLoading,
        boxShadow: AppShadows.redGlow,
        textStyle: AppTextStyles.font16Bold.copyWith(color: AppColors.white),
        onTap: () => context.read<PayCommissionCubit>().pay(bookingId),
      ),
    );
  }
}
