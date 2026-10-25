import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'custom_card_widget.dart';

/// Card with a bold title, bullet lines and an optional muted footnote.
class BulletListCardWidget extends StatelessWidget {
  const BulletListCardWidget({
    required this.title,
    required this.lines,
    super.key,
    this.footnote,
  });

  final String title;
  final List<String> lines;
  final String? footnote;

  @override
  Widget build(BuildContext context) {
    final lineStyle = AppTextStyles.font13Regular.copyWith(
      color: AppColors.textBody,
      height: 21 / 13,
    );

    return CustomCardWidget(
      padding: EdgeInsets.fromLTRB(16.w, 11.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: AppTextStyles.font15Bold),
          for (final line in lines) ...[
            hSpace(8),
            Text(line, style: lineStyle),
          ],
          if (footnote != null) ...[
            hSpace(8),
            Text(footnote!, style: AppTextStyles.font12Regular),
          ],
        ],
      ),
    );
  }
}
