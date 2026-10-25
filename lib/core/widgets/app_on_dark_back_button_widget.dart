import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/app_assets.dart';

/// Bare white back arrow used on navy headers.
class AppOnDarkBackButtonWidget extends StatelessWidget {
  const AppOnDarkBackButtonWidget({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.all(11.r),
        child: Transform.flip(
          flipX: Directionality.of(context) == TextDirection.ltr,
          child: SvgPicture.asset(AppAssets.icArrowBackWhite, width: 22.r, height: 22.r),
        ),
      ),
    );
  }
}
