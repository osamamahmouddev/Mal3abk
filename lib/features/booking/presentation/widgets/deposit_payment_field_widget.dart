import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

class DepositPaymentFieldWidget extends StatelessWidget {
  const DepositPaymentFieldWidget({
    required this.label,
    required this.value,
    super.key,
    this.isHighlight = false,
    this.canCopy = false,
  });

  final String label;
  final String value;
  final bool isHighlight;
  final bool canCopy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.font13Regular),
          Row(
            children: [
              Text(
                value,
                style: isHighlight
                    ? AppTextStyles.font18Bold.copyWith(color: AppColors.brandNavy)
                    : AppTextStyles.font14Bold,
              ),
              if (canCopy) ...[
                vSpace(6),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: value));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم نسخ الرقم')),
                    );
                  },
                  child: Icon(Icons.copy_rounded, size: 18.sp, color: AppColors.brandNavy),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
