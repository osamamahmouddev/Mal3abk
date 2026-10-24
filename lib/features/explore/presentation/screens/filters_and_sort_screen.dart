import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_chip_widget.dart';

class FiltersAndSortScreen extends StatefulWidget {
  const FiltersAndSortScreen({super.key});

  @override
  State<FiltersAndSortScreen> createState() => _FiltersAndSortScreenState();
}

class _FiltersAndSortScreenState extends State<FiltersAndSortScreen> {
  String _selectedSort = 'الأقرب مسافة';
  String _selectedPitchType = 'نجيل صناعي';
  String _selectedPitchSize = '٥ ضد ٥';
  RangeValues _priceRange = const RangeValues(100, 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBarWidget(
        title: 'الفلاتر والترتيب',
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedSort = 'الأقرب مسافة';
                _selectedPitchType = 'نجيل صناعي';
                _selectedPitchSize = '٥ ضد ٥';
                _priceRange = const RangeValues(100, 300);
              });
            },
            child: Text(
              'إعادة تعيين',
              style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.brandRed),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'تطبيق الفلاتر',
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
              Text('الترتيب حسب', style: AppTextStyles.font15Bold),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: ['الأقرب مسافة', 'الأعلى تقييماً', 'الأقل سعراً', 'الأكثر حجماً'].map((sort) {
                  return CustomChipWidget(
                    label: sort,
                    isSelected: _selectedSort == sort,
                    onTap: () => setState(() => _selectedSort = sort),
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),

              Text('نوع النجيل', style: AppTextStyles.font15Bold),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: ['الكل', 'نجيل صناعي', 'نجيل طبيعي', 'صالات ترتان'].map((type) {
                  return CustomChipWidget(
                    label: type,
                    isSelected: _selectedPitchType == type,
                    onTap: () => setState(() => _selectedPitchType = type),
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),

              Text('حجم الملعب', style: AppTextStyles.font15Bold),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: ['٥ ضد ٥', '٧ ضد ٧', '٩ ضد ٩', '١١ ضد ١١'].map((size) {
                  return CustomChipWidget(
                    label: size,
                    isSelected: _selectedPitchSize == size,
                    onTap: () => setState(() => _selectedPitchSize = size),
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('نطاق السعر للساعة', style: AppTextStyles.font15Bold),
                  Text(
                    '${_priceRange.start.round()} - ${_priceRange.end.round()} ج.م',
                    style: AppTextStyles.font13SemiBold.copyWith(color: AppColors.brandNavy),
                  ),
                ],
              ),
              RangeSlider(
                values: _priceRange,
                min: 50,
                max: 500,
                divisions: 9,
                activeColor: AppColors.brandNavy,
                inactiveColor: AppColors.border,
                onChanged: (values) => setState(() => _priceRange = values),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

