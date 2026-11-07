import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_assets.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../reference/presentation/cubit/governorates_cubit.dart';
import '../cubit/home_feed_cubit.dart';
import '../cubit/home_feed_state.dart';
import 'home_area_sheet_widget.dart';
import 'home_location_label_bloc_builder.dart';
import 'home_notifications_button_bloc_builder.dart';

/// The area the feed is for (tap to change it) and the notifications bell.
class HomeLocationHeaderWidget extends StatelessWidget {
  const HomeLocationHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> changeArea() async {
      HapticFeedback.selectionClick();
      final feed = context.read<HomeFeedCubit>();
      final current = feed.state is HomeFeedSuccess
          ? (feed.state as HomeFeedSuccess).located
          : null;
      final picked = await HomeAreaSheetWidget.show(
        context,
        governorates: context.read<GovernoratesCubit>(),
        initialCity: current?.city,
      );
      if (picked != null) {
        await feed.fetchFeed(city: picked.city, area: picked.area);
      }
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.borderCard)),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: InkWell(
                onTap: changeArea,
                borderRadius: BorderRadius.circular(14.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: const BoxDecoration(
                          color: AppColors.redLight,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(10.r),
                        child: SvgPicture.asset(AppAssets.icPinSmall),
                      ),
                      vSpace(10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'home.current_location'.tr(context: context),
                              style: AppTextStyles.font12Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            hSpace(1),
                            Row(
                              children: [
                                const Flexible(
                                  child: HomeLocationLabelBlocBuilder(),
                                ),
                                vSpace(2),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 20.r,
                                  color: AppColors.brandNavy,
                                ),
                              ],
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
          vSpace(12),
          const HomeNotificationsButtonBlocBuilder(),
        ],
      ),
    );
  }
}
