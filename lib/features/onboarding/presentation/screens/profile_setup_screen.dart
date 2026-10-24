import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  String _selectedPosition = 'وسط';
  String _selectedLevel = 'متوسط';

  @override
  void dispose() {
    _nameController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.pageBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.brandNavy,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Step indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('خطوة ١ من ٢', style: AppTextStyles.font13Regular),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.brandRed,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.borderInput,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text('عرّفنا بنفسك', style: AppTextStyles.font22Bold),
              SizedBox(height: 6.h),
              Text(
                'الاسم والمنطقة بس مطلوبين. الباقي يساعد الكباتن يلاقوك.',
                style: AppTextStyles.font13Regular,
              ),
              SizedBox(height: 24.h),

              // Profile Avatar
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 38.r,
                      backgroundColor: AppColors.brandNavy,
                      child: Text(
                        'أس',
                        style: AppTextStyles.font22Bold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: const BoxDecoration(
                          color: AppColors.brandRed,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 16.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              CustomTextFormField(
                controller: _nameController,
                labelText: 'اسمك بالكامل *',
                hintText: 'أحمد سامي',
              ),
              SizedBox(height: 16.h),

              CustomTextFormField(
                controller: _areaController,
                labelText: 'المنطقة أو الحي *',
                hintText: 'مدينة نصر، القاهرة',
              ),
              SizedBox(height: 20.h),

              Text(
                'مركزك في الملعب (اختار واحد)',
                style: AppTextStyles.font14SemiBold,
              ),
              SizedBox(height: 10.h),
              Row(
                children: ['حارس', 'دفاع', 'وسط', 'هجوم'].map((pos) {
                  final isSelected = _selectedPosition == pos;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: InkWell(
                        onTap: () => setState(() => _selectedPosition = pos),
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          height: 44.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.brandNavy
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.brandNavy
                                  : AppColors.borderInput,
                              width: 1.2,
                            ),
                          ),
                          child: Text(
                            pos,
                            style: isSelected
                                ? AppTextStyles.font14Bold.copyWith(
                                    color: AppColors.white,
                                  )
                                : AppTextStyles.font14Medium.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h),

              Text('مستواك (اختياري)', style: AppTextStyles.font14SemiBold),
              SizedBox(height: 10.h),
              Row(
                children:
                    [
                      {'title': 'مبتدئ', 'sub': 'بلعب للمتعة'},
                      {'title': 'متوسط', 'sub': 'بلعب كل أسبوع'},
                      {'title': 'متقدم', 'sub': 'لعبت في نادي'},
                    ].map((item) {
                      final isSelected = _selectedLevel == item['title'];
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: InkWell(
                            onTap: () =>
                                setState(() => _selectedLevel = item['title']!),
                            borderRadius: BorderRadius.circular(10.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.brandNavy
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.brandNavy
                                      : AppColors.borderInput,
                                  width: 1.2,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item['title']!,
                                    style: isSelected
                                        ? AppTextStyles.font14Bold.copyWith(
                                            color: AppColors.white,
                                          )
                                        : AppTextStyles.font14Medium.copyWith(
                                            color: AppColors.textPrimary,
                                          ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    item['sub']!,
                                    style: AppTextStyles.font11Regular.copyWith(
                                      color: isSelected
                                          ? AppColors.white.withValues(
                                              alpha: 0.8,
                                            )
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
              SizedBox(height: 36.h),

              CustomButton(
                text: 'التالي',
                type: CustomButtonType.primary,
                height: 52.h,
                onTap: () => Navigator.of(
                  context,
                ).pushNamed(AppRoutes.locationPermission),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
