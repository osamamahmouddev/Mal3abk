import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_colors.dart';

/// The small bar at the top of a bottom sheet.
class SheetDragHandleWidget extends StatelessWidget {
  const SheetDragHandleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 44.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: AppColors.borderInput,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }
}
