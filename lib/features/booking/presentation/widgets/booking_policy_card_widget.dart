import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class BookingPolicyCardWidget extends StatelessWidget {
  const BookingPolicyCardWidget({
    required this.agreedToPolicy,
    required this.onChanged,
    super.key,
  });

  final bool agreedToPolicy;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'booking.policy_title'.tr(context: context),
            style: AppTextStyles.font15Bold,
          ),
          hSpace(8),
          Text(
            'booking.policy_rule_1'.tr(context: context),
            style: AppTextStyles.font12Regular,
          ),
          hSpace(4),
          Text(
            'booking.policy_rule_2'.tr(context: context),
            style: AppTextStyles.font12Regular,
          ),
          hSpace(10),
          Row(
            children: [
              Checkbox(
                value: agreedToPolicy,
                activeColor: AppColors.brandNavy,
                onChanged: onChanged,
              ),
              Expanded(
                child: Text(
                  'booking.agree_policy'.tr(context: context),
                  style: AppTextStyles.font13SemiBold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
