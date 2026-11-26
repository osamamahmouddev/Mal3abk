import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/utils/cairo_time.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/venue_thumbnail_widget.dart';
import '../../data/models/map_venue_pin_model.dart';
import '../screens/pitch_and_time_screen.dart';

/// The tapped venue: price, next free slot, and ways into it.
class ExploreMapVenueSheetWidget extends StatelessWidget {
  const ExploreMapVenueSheetWidget({
    required this.pin,
    required this.onClose,
    super.key,
  });

  final MapVenuePinModel pin;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final navigator = Navigator.of(context);
    final next = pin.nextAvailableStartUtc;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyShadow18,
            offset: Offset(0, 4.h),
            blurRadius: 16.r,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VenueThumbnailWidget(imageUrl: pin.coverPhotoUrl, size: 56),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pin.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font16Bold,
                    ),
                    if (pin.fromHourlyPrice case final price?)
                      Text(
                        '${'explore.venue.starts_from'.tr(context: context)} ${'common.price_egp'.tr(context: context, args: [price.round().toLocalizedDigits(lang)])}',
                        style: AppTextStyles.font13SemiBold.copyWith(
                          color: AppColors.goldDark,
                        ),
                      ),
                    hSpace(4),
                    Text(
                      next == null
                          ? 'home.no_slots_soon'.tr(context: context)
                          : 'explore.next_available'.tr(
                              context: context,
                              args: [
                                CairoTime.dayAndTime(
                                  CairoTime.parseUtc(next),
                                  lang,
                                ),
                              ],
                            ),
                      style: AppTextStyles.font12Regular,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close_rounded),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          hSpace(12),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'explore.view_venue'.tr(context: context),
                  type: CustomButtonType.outline,
                  height: 44.h,
                  borderRadius: 10,
                  borderColor: AppColors.brandNavy,
                  textStyle: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.brandNavy,
                  ),
                  onTap: () => navigator.pushNamed(
                    AppRoutes.venueProfile,
                    arguments: pin.venueId,
                  ),
                ),
              ),
              vSpace(8),
              Expanded(
                child: CustomButton(
                  text: 'explore.venue.book'.tr(context: context),
                  height: 44.h,
                  borderRadius: 10,
                  textStyle: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.white,
                  ),
                  onTap: () => navigator.pushNamed(
                    AppRoutes.pitchAndTime,
                    arguments: PitchAndTimeArgs(
                      venueId: pin.venueId,
                      venueName: pin.name,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
