import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/widgets/custom_skeleton_widget.dart';

class HomeSkeletonWidget extends StatelessWidget {
  const HomeSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSkeletonWidget(width: 120.w, height: 18.h, borderRadius: 9),
          hSpace(14),
          CustomSkeletonWidget(height: 86.h, borderRadius: 16),
          hSpace(14),
          CustomSkeletonWidget(width: 150.w, height: 18.h, borderRadius: 9),
          hSpace(14),
          Row(
            children: [
              Expanded(
                flex: 256,
                child: CustomSkeletonWidget(height: 190.h, borderRadius: 16),
              ),
              vSpace(12),
              Expanded(
                flex: 90,
                child: CustomSkeletonWidget(height: 190.h, borderRadius: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
