import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'app_back_button_widget.dart';

/// Figma page header: back button at the start, title centered.
class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarWidget({
    required this.title,
    super.key,
    this.showBackButton = true,
    this.onBackTap,
    this.actions,
    this.subtitle,
    this.bottom,
    this.backgroundColor,
    this.isClose = false,
  });

  final String title;
  final bool showBackButton;
  final VoidCallback? onBackTap;
  final List<Widget>? actions;
  final String? subtitle;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final bool isClose;

  @override
  Size get preferredSize => Size.fromHeight(
        72.h + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.pageBackground,
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 72.h,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            if (showBackButton)
              AppBackButtonWidget(onTap: onBackTap, isClose: isClose)
            else
              Container(width: 44.r),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.font18Bold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTextStyles.font12Regular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
            if (actions != null)
              Row(mainAxisSize: MainAxisSize.min, children: actions!)
            else
              Container(width: 44.r),
          ],
        ),
      ),
      bottom: bottom,
    );
  }
}
