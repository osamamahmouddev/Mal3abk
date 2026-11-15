import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/empty_note_box_widget.dart';
import '../../data/models/localized_item_model.dart';

class VenueAmenitiesTabWidget extends StatelessWidget {
  const VenueAmenitiesTabWidget({required this.facilities, super.key});

  final List<LocalizedItemModel> facilities;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    if (facilities.isEmpty) {
      return EmptyNoteBoxWidget(
        text: 'explore.venue.no_amenities'.tr(context: context),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top summary banner
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderCard),
          ),
          child: Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.sports_soccer_rounded,
                  size: 20.r,
                  color: AppColors.pitchGreenDark,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'explore.venue.amenities_title'.tr(context: context),
                      style: AppTextStyles.font14Bold,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'explore.venue.amenities_count'.tr(
                        context: context,
                        args: [facilities.length.toString()],
                      ),
                      style: AppTextStyles.font12Medium.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      size: 13.r,
                      color: AppColors.pitchGreenDark,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'explore.venue.available'.tr(context: context),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.pitchGreenDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // 2-Column responsive grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: facilities.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 2.2,
          ),
          itemBuilder: (context, index) {
            final item = facilities[index];
            final visual = _resolveVisual(item.code, item.nameAr, item.nameEn);
            final name = lang == 'ar' ? item.nameAr : item.nameEn;

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColors.borderCard),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38.r,
                    height: 38.r,
                    decoration: BoxDecoration(
                      color: visual.backgroundColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      visual.icon,
                      size: 20.r,
                      color: visual.iconColor,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font13Bold,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              size: 11.r,
                              color: AppColors.pitchGreenDark,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              'explore.venue.available'.tr(context: context),
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.pitchGreenDark,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _FacilityVisual {
  const _FacilityVisual({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
}

_FacilityVisual _resolveVisual(String code, String nameAr, String nameEn) {
  final c = code.toLowerCase().trim();
  final n = '$nameAr $nameEn'.toLowerCase();

  if (c == 'lighting' ||
      n.contains('إضاءة') ||
      n.contains('lighting') ||
      n.contains('floodlight')) {
    return const _FacilityVisual(
      icon: Icons.lightbulb_rounded,
      iconColor: Color(0xFFD97706),
      backgroundColor: Color(0xFFFEF3C7),
    );
  }
  if (c == 'parking' || n.contains('سيار') || n.contains('parking')) {
    return const _FacilityVisual(
      icon: Icons.local_parking_rounded,
      iconColor: Color(0xFF2563EB),
      backgroundColor: Color(0xFFEFF6FF),
    );
  }
  if (c == 'changing_rooms' ||
      n.contains('ملابس') ||
      n.contains('changing') ||
      n.contains('locker')) {
    return const _FacilityVisual(
      icon: Icons.checkroom_rounded,
      iconColor: Color(0xFF7C3AED),
      backgroundColor: Color(0xFFF5F3FF),
    );
  }
  if (c == 'showers' ||
      n.contains('دش') ||
      n.contains('دُش') ||
      n.contains('shower')) {
    return const _FacilityVisual(
      icon: Icons.shower_rounded,
      iconColor: Color(0xFF0284C7),
      backgroundColor: Color(0xFFF0F9FF),
    );
  }
  if (c == 'toilets' ||
      n.contains('دورات') ||
      n.contains('مرحاض') ||
      n.contains('toilet') ||
      n.contains('restroom')) {
    return const _FacilityVisual(
      icon: Icons.wc_rounded,
      iconColor: Color(0xFF475569),
      backgroundColor: Color(0xFFF1F5F9),
    );
  }
  if (c == 'cafeteria' ||
      n.contains('كافيتريا') ||
      n.contains('مقهى') ||
      n.contains('cafe') ||
      n.contains('cafeteria')) {
    return const _FacilityVisual(
      icon: Icons.local_cafe_rounded,
      iconColor: Color(0xFFEA580C),
      backgroundColor: Color(0xFFFFF7ED),
    );
  }
  if (c == 'drinking_water' || n.contains('شرب') || n.contains('water')) {
    return const _FacilityVisual(
      icon: Icons.water_drop_rounded,
      iconColor: Color(0xFF0891B2),
      backgroundColor: Color(0xFFECFEFF),
    );
  }
  if (c == 'seating' ||
      n.contains('مقاعد') ||
      n.contains('جمهور') ||
      n.contains('seat') ||
      n.contains('spectator')) {
    return const _FacilityVisual(
      icon: Icons.event_seat_rounded,
      iconColor: Color(0xFF0D9488),
      backgroundColor: Color(0xFFF0FDFA),
    );
  }
  if (c == 'prayer_room' ||
      n.contains('مصلى') ||
      n.contains('مسجد') ||
      n.contains('prayer') ||
      n.contains('mosque')) {
    return const _FacilityVisual(
      icon: Icons.mosque_rounded,
      iconColor: Color(0xFF16A34A),
      backgroundColor: Color(0xFFF0FDF4),
    );
  }
  if (c == 'first_aid' ||
      n.contains('إسعاف') ||
      n.contains('اسعاف') ||
      n.contains('first aid') ||
      n.contains('medical')) {
    return const _FacilityVisual(
      icon: Icons.medical_services_rounded,
      iconColor: Color(0xFFE11D48),
      backgroundColor: Color(0xFFFFF1F2),
    );
  }
  if (c == 'ball_rental' || n.contains('كرة') || n.contains('ball')) {
    return const _FacilityVisual(
      icon: Icons.sports_soccer_rounded,
      iconColor: AppColors.pitchGreenDark,
      backgroundColor: AppColors.successLight,
    );
  }
  if (c == 'bibs' ||
      n.contains('ببات') ||
      n.contains('بِبات') ||
      n.contains('صدير') ||
      n.contains('bib') ||
      n.contains('pinnie')) {
    return const _FacilityVisual(
      icon: Icons.shield_outlined,
      iconColor: Color(0xFFCA8A04),
      backgroundColor: Color(0xFFFEF9C3),
    );
  }
  if (c == 'wifi' ||
      n.contains('واي فاي') ||
      n.contains('wifi') ||
      n.contains('wi-fi') ||
      n.contains('انترنت') ||
      n.contains('إنترنت')) {
    return const _FacilityVisual(
      icon: Icons.wifi_rounded,
      iconColor: Color(0xFF4F46E5),
      backgroundColor: Color(0xFFEEF2FF),
    );
  }
  if (c == 'referee' ||
      n.contains('حكم') ||
      n.contains('حَكَم') ||
      n.contains('referee')) {
    return const _FacilityVisual(
      icon: Icons.sports_rounded,
      iconColor: AppColors.brandNavy,
      backgroundColor: AppColors.lightSurface,
    );
  }

  return const _FacilityVisual(
    icon: Icons.verified_rounded,
    iconColor: AppColors.pitchGreenDark,
    backgroundColor: AppColors.successLight,
  );
}
