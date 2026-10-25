import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'custom_card_widget.dart';

/// White card with a bold title and a body paragraph.
class InfoNoteCardWidget extends StatelessWidget {
  const InfoNoteCardWidget({
    required this.title,
    required this.body,
    super.key,
  });

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      borderRadius: 18,
      padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: AppTextStyles.font14Bold),
          hSpace(10),
          Text(
            body,
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.textBody,
              height: 21 / 13,
            ),
          ),
        ],
      ),
    );
  }
}
