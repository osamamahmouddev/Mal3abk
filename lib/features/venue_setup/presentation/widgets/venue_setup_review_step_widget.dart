import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/presentation/venue_format.dart';
import '../../../venue_shell/presentation/widgets/venue_section_card_widget.dart';
import '../cubit/venue_setup_cubit.dart';
import '../cubit/venue_setup_state.dart';

/// Step 4: how the venue earns (commission model) and sending it for review.
class VenueSetupReviewStepWidget extends HookWidget {
  const VenueSetupReviewStepWidget({required this.onOpenDashboard, super.key});

  final VoidCallback onOpenDashboard;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VenueSetupCubit>();
    final message = useTextEditingController();
    String t(String key) => 'venue.setup.review.$key'.tr(context: context);

    return BlocBuilder<VenueSetupCubit, VenueSetupState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t('intro'),
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            hSpace(12),
            if (state.venue case final venue?)
              CommissionTermsWidget(venue: venue),
            hSpace(12),
            if (state.canSubmit) ...[
              CustomTextFormField(
                controller: message,
                labelText: t('message'),
                hintText: t('message_hint'),
                minLines: 2,
                maxLines: 4,
                textInputAction: TextInputAction.done,
              ),
              hSpace(14),
              CustomButton(
                text: t('submit'),
                height: 52.h,
                borderRadius: 14,
                isLoading: state.saving,
                textStyle: AppTextStyles.font16Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: () => cubit.submitForReview(message.text),
              ),
            ] else ...[
              Container(
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.successGreen,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        state.approvalStatus == 'Approved'
                            ? t('approved')
                            : t('submitted'),
                        style: AppTextStyles.font13SemiBold.copyWith(
                          color: AppColors.successText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              hSpace(14),
              CustomButton(
                text: t('open_dashboard'),
                height: 52.h,
                borderRadius: 14,
                textStyle: AppTextStyles.font16Bold.copyWith(
                  color: AppColors.white,
                ),
                onTap: onOpenDashboard,
              ),
            ],
          ],
        );
      },
    );
  }
}

/// How a venue earns on Malabak: commission on app bookings only.
class CommissionTermsWidget extends StatelessWidget {
  const CommissionTermsWidget({required this.venue, super.key});

  final VenueModel venue;

  @override
  Widget build(BuildContext context) {
    String t(String key) => 'venue.commission.$key'.tr(context: context);
    final rate = venue.commissionRate == null
        ? null
        : VenueFormat.number(context, venue.commissionRate!);
    final label = switch (venue.commissionType) {
      'Percentage' when rate != null => 'venue.commission.percentage_rate'.tr(
        context: context,
        args: [rate],
      ),
      'Percentage' => t('percentage'),
      'PerHourFixed' when rate != null => 'venue.commission.per_hour_rate'.tr(
        context: context,
        args: [rate],
      ),
      'PerHourFixed' => t('per_hour'),
      'Exempt' => t('exempt'),
      _ => t('default'),
    };
    final steps = [
      (Icons.smartphone_rounded, t('step_1')),
      (Icons.receipt_long_rounded, t('step_2')),
      (
        Icons.percent_rounded,
        'venue.commission.step_3'.tr(context: context, args: [label]),
      ),
      (Icons.payments_rounded, t('step_4')),
      (Icons.event_available_rounded, t('step_5')),
    ];
    return VenueSectionCardWidget(
      title: t('title'),
      subtitle: t('subtitle'),
      child: Column(
        children: [
          for (final (icon, text) in steps)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 18.r, color: AppColors.brandNavy),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(text, style: AppTextStyles.font13Regular),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
