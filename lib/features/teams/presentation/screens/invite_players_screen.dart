import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class InvitePlayersScreen extends StatelessWidget {
  const InvitePlayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'دعوة لاعبين للفريق'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomCardWidget(
                child: Column(
                  children: [
                    Text('كود دعوة الفريق', style: AppTextStyles.font14Regular),
                    SizedBox(height: 8.h),
                    Text(
                      'NGM-7842',
                      style: AppTextStyles.font24Bold.copyWith(
                        color: AppColors.brandNavy,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'شارك الكود ده مع أي لاعب عشان ينضم لفريقك فوراً من التطبيق.',
                      style: AppTextStyles.font12Regular,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    CustomButton(
                      text: 'نسخ الكود ومشاركته',
                      icon: const Icon(Icons.share_rounded, color: AppColors.white),
                      type: CustomButtonType.secondary,
                      height: 46.h,
                      onTap: () {},
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

