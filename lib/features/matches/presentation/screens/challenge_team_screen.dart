import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class ChallengeTeamScreen extends HookWidget {
  const ChallengeTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDayIndex = useState(0);
    final selectedTime = useState('٨:٠٠ م');
    final venueOption = useState(0);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'matches.challenge_team_title'.tr(context: context),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.border, width: 1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'السبت ٢ أغسطس · ٨:٠٠ م · ملعب النجوم',
                style: AppTextStyles.font12Regular,
              ),
              hSpace(8),
              CustomButton(
                text: 'أرسل التحدي',
                type: CustomButtonType.primary,
                height: 52.h,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.brandNavy,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundColor: AppColors.white,
                          child: Text(
                            'نج',
                            style: AppTextStyles.font16Bold.copyWith(
                              color: AppColors.brandNavy,
                            ),
                          ),
                        ),
                        hSpace(6),
                        Text(
                          'فريق النجوم',
                          style: AppTextStyles.font14Bold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          'فريقك',
                          style: AppTextStyles.font11Regular.copyWith(
                            color: AppColors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'common.vs'.tr(context: context),
                      style: AppTextStyles.font18Bold.copyWith(
                        color: AppColors.accentGold,
                      ),
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundColor: AppColors.brandRed,
                          child: Text(
                            'صق',
                            style: AppTextStyles.font16Bold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        hSpace(6),
                        Text(
                          'فريق الصقور',
                          style: AppTextStyles.font14Bold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          '#٢ في مدينة نصر',
                          style: AppTextStyles.font11Regular.copyWith(
                            color: AppColors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              hSpace(18),
              Text('اليوم المقترح', style: AppTextStyles.font15Bold),
              hSpace(10),
              RSizedBox(
                height: 64.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (_, _) => vSpace(8),
                  itemBuilder: (context, index) {
                    final isSelected = selectedDayIndex.value == index;
                    return InkWell(
                      onTap: () => selectedDayIndex.value = index,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: 60.w,
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.brandNavy
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.brandNavy
                                : AppColors.borderInput,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'السبت',
                              style: AppTextStyles.font11Regular.copyWith(
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              '${index + 2}',
                              style: AppTextStyles.font15Bold.copyWith(
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              hSpace(18),
              Text('الساعة', style: AppTextStyles.font15Bold),
              hSpace(10),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: ['٧:٠٠ م', '٨:٠٠ م', '٩:٠٠ م', '١٠:٠٠ م', '١٢:٠٠ ص']
                    .map((time) {
                      final isSelected = selectedTime.value == time;
                      return InkWell(
                        onTap: () => selectedTime.value = time,
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.brandNavy
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.brandNavy
                                  : AppColors.borderInput,
                            ),
                          ),
                          child: Text(
                            time,
                            style: isSelected
                                ? AppTextStyles.font13SemiBold.copyWith(
                                    color: AppColors.white,
                                  )
                                : AppTextStyles.font13SemiBold,
                          ),
                        ),
                      );
                    })
                    .toList(),
              ),
              hSpace(18),
              Text('الملعب', style: AppTextStyles.font15Bold),
              hSpace(10),
              CustomCardWidget(
                onTap: () => venueOption.value = 0,
                borderColor: venueOption.value == 0
                    ? AppColors.brandNavy
                    : AppColors.borderCard,
                child: Row(
                  children: [
                    Icon(
                      venueOption.value == 0
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: AppColors.brandNavy,
                      size: 20.sp,
                    ),
                    vSpace(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ملعب النجوم — مدينة نصر',
                            style: AppTextStyles.font14Bold,
                          ),
                          Text(
                            'ملعب ١ · ٥ لاعب · ١٥٠ ج.م/ساعة',
                            style: AppTextStyles.font12Regular,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              hSpace(10),
              CustomCardWidget(
                onTap: () => venueOption.value = 1,
                borderColor: venueOption.value == 1
                    ? AppColors.brandNavy
                    : AppColors.borderCard,
                child: Row(
                  children: [
                    Icon(
                      venueOption.value == 1
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: AppColors.brandNavy,
                      size: 20.sp,
                    ),
                    vSpace(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'نتفق على الملعب بعدين',
                            style: AppTextStyles.font14Bold,
                          ),
                          Text(
                            'الكابتن التاني يقدر يقترح ملعب مناسب',
                            style: AppTextStyles.font12Regular,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
