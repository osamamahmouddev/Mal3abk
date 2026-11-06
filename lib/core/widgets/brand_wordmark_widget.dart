import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../styles/app_assets.dart';

class BrandWordmarkWidget extends StatelessWidget {
  const BrandWordmarkWidget({
    super.key,
    this.titleStyle,
    this.latinStyle,
    this.accentColor,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.isDarkBackground = false,
    this.height,
  });

  final TextStyle? titleStyle;
  final TextStyle? latinStyle;
  final Color? accentColor;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isDarkBackground;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      isDarkBackground
          ? AppAssets.logoHorizontalWhite
          : AppAssets.logoHorizontalNavy,
      height: height ?? 52.h,
      fit: BoxFit.contain,
    );
  }
}
