import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';

class PitchAndTimeScreen extends StatefulWidget {
  const PitchAndTimeScreen({super.key});

  @override
  State<PitchAndTimeScreen> createState() => _PitchAndTimeScreenState();
}

class _PitchAndTimeScreenState extends State<PitchAndTimeScreen> {
  int _selectedDateIndex = 0;
  String _selectedSlot = '٨:٠٠ م';
  String _duration = 'ساعة';

  final List<String> _slots = [
    '٨:٠٠ م',
    '٩:٠٠ م',
    '١٠:٠٠ م',
    '١١:٠٠ م',
    '١٢:٠٠ ص',
    '١:٠٠ ص',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(
        title: 'الملعب والميعاد',
        subtitle: 'ملعب النجوم — ملعب ١',
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.border, width: 1)),
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ملعب ١ · $_selectedSlot · $_duration', style: AppTextStyles.font11Regular),
                  Text('١٥٠ ج.م', style: AppTextStyles.font18Bold.copyWith(color: AppColors.brandNavy)),
                ],
              ),
              const Spacer(),
              CustomButton(
                text: 'متابعة الحجز',
                type: CustomButtonType.primary,
                width: 160.w,
                height: 48.h,
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.bookingReview),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('اختر اليوم', style: AppTextStyles.font15Bold),
              SizedBox(height: 10.h),
              SizedBox(
                height: 72.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  separatorBuilder: (_, _) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) {
                    final isSelected = _selectedDateIndex == index;
                    return InkWell(
                      onTap: () => setState(() => _selectedDateIndex = index),
                      borderRadius: BorderRadius.circular(14.r),
                      child: Container(
                        width: 64.w,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.brandNavy : AppColors.white,
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: isSelected ? AppColors.brandNavy : AppColors.borderInput,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              index == 0 ? 'اليوم' : 'السبت',
                              style: AppTextStyles.font11Regular.copyWith(
                                color: isSelected ? AppColors.white.withValues(alpha: 0.8) : AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${26 + index}',
                              style: AppTextStyles.font16Bold.copyWith(
                                color: isSelected ? AppColors.white : AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),

              Text('المواعيد المتاحة', style: AppTextStyles.font15Bold),
              SizedBox(height: 10.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 2.1,
                ),
                itemCount: _slots.length,
                itemBuilder: (context, index) {
                  final slot = _slots[index];
                  final isBooked = index == 1; // sample booked
                  final isSelected = _selectedSlot == slot;

                  return InkWell(
                    onTap: isBooked ? null : () => setState(() => _selectedSlot = slot),
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isBooked
                            ? AppColors.lightSurface
                            : (isSelected ? AppColors.brandNavy : AppColors.white),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: isSelected ? AppColors.brandNavy : AppColors.borderInput,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        isBooked ? '$slot (محجوز)' : slot,
                        style: isSelected
                            ? AppTextStyles.font13SemiBold.copyWith(color: AppColors.white)
                            : (isBooked
                                ? AppTextStyles.font11Regular.copyWith(color: AppColors.textMuted)
                                : AppTextStyles.font13SemiBold.copyWith(color: AppColors.textPrimary)),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),

              Text('مدة الحجز', style: AppTextStyles.font15Bold),
              SizedBox(height: 10.h),
              Row(
                children: ['ساعة', 'ساعتين'].map((dur) {
                  final isSelected = _duration == dur;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: InkWell(
                        onTap: () => setState(() => _duration = dur),
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          height: 46.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.brandNavy : AppColors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: isSelected ? AppColors.brandNavy : AppColors.borderInput,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            dur,
                            style: isSelected
                                ? AppTextStyles.font14Bold.copyWith(color: AppColors.white)
                                : AppTextStyles.font14Medium,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
