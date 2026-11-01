import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_text_styles.dart';

class FaqItemWidget extends StatelessWidget {
  const FaqItemWidget({
    required this.question,
    required this.answer,
    super.key,
  });

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(question, style: AppTextStyles.font13SemiBold),
      childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
      children: [Text(answer, style: AppTextStyles.font12Regular)],
    );
  }
}
