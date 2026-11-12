import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../animations/app_animations.dart';
import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'custom_bottom_nav_bar_widget.dart';

/// One nav bar tab. The selected pill behind it is drawn once by the bar and
/// glides between tabs; this widget animates its own icon and label.
class CustomBottomNavBarItemWidget extends StatelessWidget {
  const CustomBottomNavBarItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final CustomBottomNavBarItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20.r);
    final color = isSelected ? AppColors.white : AppColors.textSecondary;
    final duration = AppAnimations.duration(context, AppAnimations.base);

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          if (!isSelected) HapticFeedback.selectionClick();
          onTap();
        },
        borderRadius: radius,
        child: Container(
          height: 52.h,
          padding: EdgeInsets.only(top: 5.h),
          child: Column(
            children: [
              AnimatedScale(
                scale: isSelected ? 1.12 : 1,
                duration: duration,
                curve: AppAnimations.spring,
                child: TweenAnimationBuilder<Color?>(
                  tween: ColorTween(end: color),
                  duration: duration,
                  builder: (_, value, _) => SvgPicture.asset(
                    item.iconAsset,
                    width: 22.r,
                    height: 22.r,
                    colorFilter: ColorFilter.mode(
                      value ?? color,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              hSpace(1),
              AnimatedDefaultTextStyle(
                duration: duration,
                style:
                    (isSelected
                            ? AppTextStyles.font11Bold
                            : AppTextStyles.font11Regular)
                        .copyWith(color: color),
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
