import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/booking_details_cubit.dart';
import '../cubit/booking_details_state.dart';

/// Upload the receipt while the deposit is due, otherwise cancel while the
/// policy allows; nothing for closed bookings.
class BookingDetailsFooterBlocBuilder extends StatelessWidget {
  const BookingDetailsFooterBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingDetailsCubit, BookingDetailsState>(
      builder: (context, state) {
        if (state is! BookingDetailsSuccess) return const SizedBox.shrink();
        final booking = state.booking;
        final actions = booking.allowedActions;

        Future<void> open(String route) async {
          final cubit = context.read<BookingDetailsCubit>();
          await Navigator.of(context).pushNamed(route, arguments: booking.id);
          await cubit.load(booking.id);
        }

        if (actions.canUploadProof) {
          return BottomActionBarWidget(
            child: CustomButton(
              text: 'booking.upload.cta'.tr(context: context),
              height: 52.h,
              borderRadius: 16,
              boxShadow: AppShadows.redGlow,
              textStyle: AppTextStyles.font16Bold.copyWith(
                color: AppColors.white,
              ),
              onTap: () => open(AppRoutes.uploadProof),
            ),
          );
        }
        if (actions.canCancel) {
          return BottomActionBarWidget(
            child: CustomButton(
              text: 'booking.details.cancel'.tr(context: context),
              type: CustomButtonType.outline,
              height: 52.h,
              borderRadius: 12,
              borderColor: AppColors.redBorder,
              textStyle: AppTextStyles.font15Bold.copyWith(
                color: AppColors.redText,
              ),
              onTap: () => open(AppRoutes.cancelBooking),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
