import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/animations/app_animations.dart';
import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/media_url.dart';
import '../../../../core/widgets/press_scale_widget.dart';

class RankingsPodiumColumnWidget extends StatefulWidget {
  const RankingsPodiumColumnWidget({
    required this.initials,
    required this.name,
    required this.rank,
    required this.points,
    required this.blockHeight,
    super.key,
    this.logoUrl,
    this.isWinner = false,
    this.onTap,
    this.enterDelay = Duration.zero,
  });

  final String initials;
  final String name;
  final String rank;
  final String points;
  final double blockHeight;
  final bool isWinner;
  final String? logoUrl;

  /// Opens the team; the whole column (avatar, name and block) is the target.
  final VoidCallback? onTap;

  /// How long this column waits before entering, so the three arrive one
  /// after another instead of all at once.
  final Duration enterDelay;

  @override
  State<RankingsPodiumColumnWidget> createState() =>
      _RankingsPodiumColumnWidgetState();
}

class _RankingsPodiumColumnWidgetState extends State<RankingsPodiumColumnWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _entrance;
  bool _scheduled = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppAnimations.slow,
    );
    _entrance = CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.emphasized,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_scheduled) return;
    _scheduled = true;
    if (AppAnimations.isReduced(context)) {
      _controller.value = 1;
    } else {
      Future.delayed(widget.enterDelay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avatarSize = (widget.isWinner ? 62 : 52).r;
    final fg = widget.isWinner ? AppColors.brandNavy : AppColors.white;
    final resolvedLogo = MediaUrl.resolve(widget.logoUrl);

    return FadeTransition(
      opacity: _entrance,
      child: ScaleTransition(
        scale: Tween(begin: 0.8, end: 1.0).animate(_entrance),
        alignment: Alignment.bottomCenter,
        child: PressScaleWidget(
          enabled: widget.onTap != null,
          child: Semantics(
            button: widget.onTap != null,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.onTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: avatarSize,
                    height: avatarSize,
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: widget.isWinner
                            ? AppColors.accentGold
                            : AppColors.textDisabled,
                        width: 3,
                      ),
                    ),
                    child: resolvedLogo == null || resolvedLogo.isEmpty
                        ? Text(
                            widget.initials,
                            style: AppTextStyles.font16Bold.copyWith(
                              color: AppColors.brandNavy,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: resolvedLogo,
                            fit: BoxFit.cover,
                            memCacheWidth: (avatarSize * 2).round(),
                            errorWidget: (_, _, _) => Text(
                              widget.initials,
                              style: AppTextStyles.font16Bold.copyWith(
                                color: AppColors.brandNavy,
                              ),
                            ),
                          ),
                  ),
                  hSpace(4),
                  Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font13Bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  hSpace(8),
                  Container(
                    height: widget.blockHeight.h,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: widget.isWinner
                          ? AppColors.accentGold
                          : AppColors.white14,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.r),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.rank,
                          style: AppTextStyles.font20Bold.copyWith(color: fg),
                        ),
                        Text(
                          widget.points,
                          style: AppTextStyles.font11Regular.copyWith(
                            color: fg,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
