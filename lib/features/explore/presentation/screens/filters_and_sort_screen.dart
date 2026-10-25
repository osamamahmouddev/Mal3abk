import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_chip_widget.dart';

class FiltersAndSortScreen extends HookWidget {
  const FiltersAndSortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedSort = useState('الأقرب مسافة');
    final selectedPitchType = useState('نجيل صناعي');
    final selectedPitchSize = useState('٥ ضد ٥');
    final priceRange = useState(const RangeValues(100, 300));

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBarWidget(
        title: 'explore.filter_and_sort'.tr(context: context),
        actions: [
          CustomButton(
            text: 'explore.reset'.tr(context: context),
            type: CustomButtonType.ghost,
            foregroundColor: AppColors.brandRed,
            onTap: () {
              selectedSort.value = 'الأقرب مسافة';
              selectedPitchType.value = 'نجيل صناعي';
              selectedPitchSize.value = '٥ ضد ٥';
              priceRange.value = const RangeValues(100, 300);
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'explore.apply'.tr(context: context),
            type: CustomButtonType.primary,
            height: 52.h,
            onTap: () => Navigator.of(context).maybePop(),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('explore.sort_by'.tr(context: context), style: AppTextStyles.font15Bold),
              hSpace(10),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: ['الأقرب مسافة', 'الأعلى تقييماً', 'الأقل سعراً', 'الأكثر حجماً'].map((sort) {
                  return CustomChipWidget(
                    label: sort,
                    isSelected: selectedSort.value == sort,
                    onTap: () => selectedSort.value = sort,
                  );
                }).toList(),
              ),
              hSpace(24),
              Text('نوع النجيل', style: AppTextStyles.font15Bold),
              hSpace(10),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: ['الكل', 'نجيل صناعي', 'نجيل طبيعي', 'صالات ترتان'].map((type) {
                  return CustomChipWidget(
                    label: type,
                    isSelected: selectedPitchType.value == type,
                    onTap: () => selectedPitchType.value = type,
                  );
                }).toList(),
              ),
              hSpace(24),
              Text('حجم الملعب', style: AppTextStyles.font15Bold),
              hSpace(10),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: ['٥ ضد ٥', '٧ ضد ٧', '٩ ضد ٩', '١١ ضد ١١'].map((size) {
                  return CustomChipWidget(
                    label: size,
                    isSelected: selectedPitchSize.value == size,
                    onTap: () => selectedPitchSize.value = size,
                  );
                }).toList(),
              ),
              hSpace(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('نطاق السعر للساعة', style: AppTextStyles.font15Bold),
                  Text(
                    '${priceRange.value.start.round()} - ${priceRange.value.end.round()} ج.م',
                    style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.brandNavy),
                  ),
                ],
              ),
              RangeSlider(
                values: priceRange.value,
                min: 50,
                max: 500,
                divisions: 9,
                activeColor: AppColors.brandNavy,
                inactiveColor: AppColors.border,
                onChanged: (values) => priceRange.value = values,
              ),
              hSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
