import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../styles/app_colors.dart';
import 'app_animations.dart';

/// The loading shimmer, drawn like a freshly mown pitch: instead of one
/// shine, a wide and a narrow light band (the mower stripes) pass across at
/// a slight slant, slower than a usual shimmer, so loading feels calm.
///
/// Same cost as a plain shimmer (one gradient); it stays still with reduced
/// motion.
class TurfShimmerWidget extends StatelessWidget {
  const TurfShimmerWidget({required this.child, super.key});

  final Widget child;

  static const Duration period = Duration(milliseconds: 1700);

  static const LinearGradient gradient = LinearGradient(
    // A slight slant, as stripes look from the stands.
    begin: Alignment(-1, -0.35),
    end: Alignment(1, 0.35),
    colors: [
      AppColors.lightSurface,
      AppColors.lightSurface,
      AppColors.white,
      AppColors.lightSurface,
      Color(0xFFFAFBFD),
      AppColors.lightSurface,
      AppColors.lightSurface,
    ],
    stops: [0, 0.32, 0.42, 0.52, 0.6, 0.66, 1],
  );

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: gradient,
      period: period,
      enabled: !AppAnimations.isReduced(context),
      child: child,
    );
  }
}
