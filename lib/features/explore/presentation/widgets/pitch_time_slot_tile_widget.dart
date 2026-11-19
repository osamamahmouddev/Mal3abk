import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/animations/live_cross_out_painters.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

/// One time on the slots grid.
///
/// When a slot changes while the player is looking (someone else booked it,
/// or it was freed), it says so with one short motion instead of just
/// switching colors:
/// - taken: a thin red ring leaves the tile ("just now"), a hand-drawn pen
///   stroke crosses the time out in reading direction, the tile sinks
///   slightly into grey and "booked" rises in. The slot the player had
///   picked first gives a small "no" shake.
/// - freed: the stroke is lifted off and a green ring says it is open.
///
/// Only a tile that changes animates (its controller is created then), each
/// tile repaints on its own layer, and nothing runs with reduced motion.
class PitchTimeSlotTileWidget extends StatefulWidget {
  const PitchTimeSlotTileWidget({
    required this.time,
    required this.isBooked,
    required this.isSelected,
    required this.onTap,
    super.key,
    this.isNextDay = false,
  });

  final String time;
  final bool isBooked;
  final bool isSelected;
  final bool isNextDay;
  final VoidCallback onTap;

  /// Length of the live change.
  static const Duration liveDuration = Duration(milliseconds: 650);

  @override
  State<PitchTimeSlotTileWidget> createState() =>
      _PitchTimeSlotTileWidgetState();
}

class _PitchTimeSlotTileWidgetState extends State<PitchTimeSlotTileWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _live;

  /// The running change closes the slot (false: frees it).
  bool _closing = true;

  /// The player had this slot picked when it was taken.
  bool _wasSelected = false;

  @override
  void didUpdateWidget(PitchTimeSlotTileWidget old) {
    super.didUpdateWidget(old);
    if (old.isBooked == widget.isBooked || AppAnimations.isReduced(context)) {
      return;
    }
    _closing = widget.isBooked;
    _wasSelected = old.isSelected;
    final live = _live ??= AnimationController(
      vsync: this,
      duration: PitchTimeSlotTileWidget.liveDuration,
    );
    live.forward(from: 0);
  }

  @override
  void dispose() {
    _live?.dispose();
    super.dispose();
  }

  /// [t] mapped through [start]-[end] of the change, then [curve].
  static double _phase(
    double t,
    double start,
    double end, [
    Curve curve = Curves.linear,
  ]) => curve.transform(((t - start) / (end - start)).clamp(0.0, 1.0));

  @override
  Widget build(BuildContext context) {
    final live = _live;
    final tile = live == null
        ? _buildTile(context, 1)
        : AnimatedBuilder(
            animation: live,
            builder: (context, _) =>
                _buildTile(context, live.isAnimating ? live.value : 1),
          );
    return RepaintBoundary(child: tile);
  }

  /// The tile [t] of the way through the last live change (1 when settled).
  Widget _buildTile(BuildContext context, double t) {
    final booked = widget.isBooked;
    final selected = widget.isSelected && !booked;
    final animating = t < 1;
    final radius = 12.r;

    // Closing: pulse, then the pen, then the tile sinks into grey.
    // Freeing: the pen lifts off, then the green pulse.
    final pulse = !animating
        ? 0.0
        : _closing
        ? _phase(t, 0, 0.5, Curves.easeOut)
        : _phase(t, 0.3, 0.85, Curves.easeOut);
    final stroke = !animating
        ? (booked ? 1.0 : 0.0)
        : _closing
        ? _phase(t, 0.15, 0.7, Curves.easeInOutCubic)
        : 1 - _phase(t, 0, 0.45, Curves.easeInCubic);
    final settle = !animating
        ? 1.0
        : _phase(t, 0.45, 0.95, AppAnimations.standard);
    final strokeColor = Color.lerp(
      AppColors.brandRed,
      AppColors.textDisabled,
      _closing ? _phase(t, 0.6, 1) : 1,
    )!;

    final restingBackground = booked
        ? AppColors.lightSurface
        : (selected ? AppColors.brandNavy : AppColors.white);
    final background = animating && _closing
        ? Color.lerp(
            _wasSelected ? AppColors.brandNavy : AppColors.white,
            AppColors.lightSurface,
            settle,
          )!
        : restingBackground;
    final timeColor = booked
        ? Color.lerp(
            _wasSelected ? AppColors.white : AppColors.textPrimary,
            AppColors.textDisabled,
            animating ? settle : 1,
          )!
        : (selected ? AppColors.white : AppColors.textPrimary);

    // A dip while it closes, a small lift when it opens again.
    final scale = !animating
        ? (selected ? 1.04 : 1.0)
        : _closing
        ? 1 - 0.05 * math.sin(math.pi * _phase(t, 0.3, 0.9))
        : 1 + 0.03 * math.sin(math.pi * _phase(t, 0.3, 0.9));
    // The picked slot slips away: two small, fading side shakes.
    final shake = animating && _closing && _wasSelected
        ? 4.r * math.sin(_phase(t, 0, 0.3) * 4 * math.pi) * (1 - t)
        : 0.0;

    final duration = animating
        ? Duration.zero
        : AppAnimations.duration(context, AppAnimations.base);
    final Widget? label = booked
        ? Opacity(
            opacity: animating && _closing ? _phase(t, 0.55, 1) : 1,
            child: Transform.translate(
              offset: Offset(
                0,
                animating && _closing ? 6.h * (1 - _phase(t, 0.55, 1)) : 0,
              ),
              child: Text(
                'explore.slots.booked'.tr(context: context),
                style: AppTextStyles.font10Regular.copyWith(
                  color: AppColors.textDisabled,
                ),
              ),
            ),
          )
        : (widget.isNextDay
              ? Text(
                  'explore.slots.next_day'.tr(context: context),
                  style: AppTextStyles.font10Bold.copyWith(
                    color: selected ? AppColors.white : AppColors.brandRed,
                  ),
                )
              : null);

    return Transform.translate(
      offset: Offset(shake, 0),
      child: CustomPaint(
        foregroundPainter: LivePulsePainter(
          progress: pulse,
          color: _closing ? AppColors.brandRed : AppColors.successGreen,
          radius: radius,
        ),
        child: AnimatedScale(
          duration: duration,
          curve: AppAnimations.spring,
          scale: scale,
          child: AnimatedContainer(
            duration: duration,
            curve: AppAnimations.standard,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: booked || selected ? background : AppColors.border,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: AppColors.brandNavy.withValues(alpha: 0.28),
                        blurRadius: 14.r,
                        offset: Offset(0, 6.h),
                      ),
                    ]
                  : const [],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: booked ? null : widget.onTap,
                borderRadius: BorderRadius.circular(radius),
                child: Container(
                  height: 58.h,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomPaint(
                        foregroundPainter: CrossOutStrokePainter(
                          progress: stroke,
                          color: strokeColor,
                          textDirection: Directionality.of(context),
                        ),
                        child: Text(
                          widget.time,
                          style: AppTextStyles.font15Bold.copyWith(
                            color: timeColor,
                          ),
                        ),
                      ),
                      ?label,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
