import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/app_checkbox_widget.dart';

class BookingPolicyCardWidget extends StatelessWidget {
  const BookingPolicyCardWidget({
    required this.agreedToPolicy,
    required this.onChanged,
    super.key,
  });

  final bool agreedToPolicy;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final ruleStyle = AppTextStyles.font13Regular.copyWith(
      color: AppColors.textBody,
    );

    return CustomCardWidget(
      padding: EdgeInsets.fromLTRB(18.w, 11.h, 18.w, 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'booking.policy_title'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(10),
          Text('booking.policy_rule_1'.tr(context: context), style: ruleStyle),
          hSpace(10),
          Text('booking.policy_rule_2'.tr(context: context), style: ruleStyle),
          hSpace(14),
          GestureDetector(
            onTap: () => onChanged(!agreedToPolicy),
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                AppCheckboxWidget(value: agreedToPolicy),
                vSpace(8),
                Expanded(
                  child: Text(
                    'booking.agree_policy'.tr(context: context),
                    style: AppTextStyles.font14SemiBold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
