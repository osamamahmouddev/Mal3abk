import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

/// White tab-root header with a large start-aligned title and optional bottom.
class PageTitleHeaderWidget extends StatelessWidget {
  const PageTitleHeaderWidget({
    required this.title,
    super.key,
    this.trailing,
    this.bottom,
  });

  final String title;
  final Widget? trailing;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 14.h),
              child: Row(
                children: [
                  Expanded(child: Text(title, style: AppTextStyles.font22Bold)),
                  ?trailing,
                ],
              ),
            ),
            ?bottom,
          ],
        ),
      ),
    );
  }
}
