import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'custom_card_widget.dart';

/// Card listing dated events with colored dots.
class TimelineCardWidget extends StatelessWidget {
  const TimelineCardWidget({
    required this.title,
    required this.entries,
    super.key,
    this.compact = false,
  });

  final String title;

  /// (text, time, dot color, highlight color or null)
  final List<(String, String, Color, Color?)> entries;

  /// Compact rows: 8px dots and 13px text.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final dot = (compact ? 8 : 10).r;
    final baseText = compact
        ? AppTextStyles.font13Regular
        : AppTextStyles.font14Regular;
    final timeStyle = compact
        ? AppTextStyles.font13Regular
        : AppTextStyles.font12Regular;

    return CustomCardWidget(
      padding: EdgeInsets.fromLTRB(16.w, 11.h, 16.w, 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: AppTextStyles.font15Bold),
          for (final (text, time, dotColor, highlight) in entries) ...[
            hSpace(compact ? 10 : 12),
            Row(
              children: [
                Container(
                  width: dot,
                  height: dot,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                vSpace(compact ? 10 : 10),
                Expanded(
                  child: Text(
                    text,
                    style: highlight == null
                        ? baseText.copyWith(color: AppColors.textPrimary)
                        : baseText.copyWith(
                            color: highlight,
                            fontWeight: FontWeight.w600,
                          ),
                  ),
                ),
                Text(time, style: timeStyle),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
