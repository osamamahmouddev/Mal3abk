import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class BookingPriceRowWidget extends StatelessWidget {
  const BookingPriceRowWidget({
    required this.label,
    required this.value,
    super.key,
    this.isBold = false,
  });

  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isBold ? AppTextStyles.font14Bold : AppTextStyles.font13Regular),
          Text(
            value,
            style: isBold
                ? AppTextStyles.font15Bold.copyWith(color: AppColors.brandNavy)
                : AppTextStyles.font13SemiBold,
          ),
        ],
      ),
    );
  }
}
