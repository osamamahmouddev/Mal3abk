import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class BookingDetailRowWidget extends StatelessWidget {
  const BookingDetailRowWidget({
    required this.label,
    required this.value,
    super.key,
    this.isBold = false,
    this.valueStyle,
  });

  final String label;
  final String value;

  /// Total-style row: both sides 15 bold.
  final bool isBold;

  /// Overrides the value style (e.g. semi-bold time, bold deposit).
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Text(
            label,
            style: isBold ? AppTextStyles.font15Bold : AppTextStyles.font14Regular,
          ),
          const Spacer(),
          Text(
            value,
            style: valueStyle ??
                (isBold
                    ? AppTextStyles.font15Bold
                    : AppTextStyles.font14Regular.copyWith(
                        color: AppColors.textPrimary,
                      )),
          ),
        ],
      ),
    );
  }
}
