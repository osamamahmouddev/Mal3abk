import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_card_widget.dart';
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
      children: [
        for (final item in facilities) ...[
          CustomCardWidget(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: AppColors.pitchGreenDark,
                  size: 20.r,
                ),
                vSpace(12),
                Expanded(
                  child: Text(
                    lang == 'ar' ? item.nameAr : item.nameEn,
                    style: AppTextStyles.font14SemiBold,
                  ),
                ),
              ],
            ),
          ),
          hSpace(8),
        ],
      ],
    );
  }
}
