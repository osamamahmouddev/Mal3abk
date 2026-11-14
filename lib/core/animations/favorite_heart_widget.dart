import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles/app_assets.dart';
import '../styles/app_colors.dart';
import 'app_animations.dart';

/// The favourite heart. Turning it on pops the heart and sends a ring out
/// from it; turning it off just shrinks back to the outline.
class FavoriteHeartWidget extends HookWidget {
  const FavoriteHeartWidget({
    required this.isFavorite,
    this.size = 20,
    super.key,
  });

  final bool isFavorite;
  final double size;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: AppAnimations.duration(
        context,
        const Duration(milliseconds: 520),
      ),
      initialValue: 1,
    );
    final previous = usePrevious(isFavorite);
    useEffect(() {
      if (previous != null && previous != isFavorite) {
        controller.forward(from: 0);
      }
      return null;
    }, [isFavorite]);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = controller.value;
        final pop = isFavorite
            ? TweenSequence<double>([
                TweenSequenceItem(
                  tween: Tween<double>(begin: 0.6, end: 1.3),
                  weight: 35,
                ),
                TweenSequenceItem(
                  tween: Tween<double>(
                    begin: 1.3,
                    end: 1,
                  ).chain(CurveTween(curve: AppAnimations.spring)),
                  weight: 65,
                ),
              ]).transform(t)
            : Tween<double>(
                begin: 0.8,
                end: 1,
              ).chain(CurveTween(curve: AppAnimations.standard)).transform(t);
        final ring = isFavorite && t < 1 ? Curves.easeOut.transform(t) : 1.0;
        return SizedBox.square(
          dimension: size * 1.6,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (ring < 1)
                Container(
                  width: size * (0.8 + ring),
                  height: size * (0.8 + ring),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.brandRed.withValues(alpha: 1 - ring),
                      width: 2 * (1 - ring) + 0.5,
                    ),
                  ),
                ),
              Transform.scale(
                scale: pop,
                child: SvgPicture.asset(
                  isFavorite
                      ? AppAssets.icHeartFilled
                      : AppAssets.icHeartOutline,
                  width: size,
                  height: size,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
