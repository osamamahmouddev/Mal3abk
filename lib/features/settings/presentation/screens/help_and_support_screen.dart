import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_badge_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'المساعدة والدعم'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('محتاج مساعدة في إيه؟', style: AppTextStyles.font15Bold),
              SizedBox(height: 10.h),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 2.4,
                children: [
                  _buildHelpTopic('مشكلة في حجز'),
                  _buildHelpTopic('تأكيد العربون'),
                  _buildHelpTopic('إلغاء واسترداد'),
                  _buildHelpTopic('شكوى من ملعب'),
                  _buildHelpTopic('فريق أو نتيجة ماتش'),
                  _buildHelpTopic('حسابي وبياناتي'),
                ],
              ),
              SizedBox(height: 20.h),

              Text('أسئلة شائعة', style: AppTextStyles.font15Bold),
              SizedBox(height: 10.h),
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildFaqItem('ليه حجزي لسه مش متأكد بعد ما رفعت الإيصال؟', 'الملعب لازم يتأكد إن التحويل وصل حسابه. ده بياخد لحد ساعتين. لو عدّى الوقت ومحدش رد، ابعت طلب من هنا وهنتابع مع الملعب.'),
                    const Divider(height: 1, color: AppColors.border),
                    _buildFaqItem('هل ملعبك بيتأكد من التحويلات؟', 'نعم، يتم ربط إيصال التحويل مباشرة بنظام الملعب لتسريع اعتماده فوراً.'),
                    const Divider(height: 1, color: AppColors.border),
                    _buildFaqItem('إمتى أسترد العربون لو لغيت؟', 'إذا تم الإلغاء قبل المهلة المحددة (٦ ساعات عادة)، يتم استرداد العربون تلقائياً أو عبر التواصل مع الملعب خلال ٣ أيام.'),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              Text('طلبات الدعم السابقة', style: AppTextStyles.font15Bold),
              SizedBox(height: 10.h),
              CustomCardWidget(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('العربون ماترجعش بعد الإلغاء', style: AppTextStyles.font14Bold),
                          SizedBox(height: 2.h),
                          Text('#SUP-2193 · ١٢ يوليو', style: AppTextStyles.font11Regular),
                        ],
                      ),
                    ),
                    const AppBadgeWidget(text: 'اتحلّت', type: AppBadgeType.success),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpTopic(String title) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderCard, width: 1),
      ),
      child: Text(title, style: AppTextStyles.font13SemiBold),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(question, style: AppTextStyles.font13SemiBold),
      childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
      children: [
        Text(answer, style: AppTextStyles.font12Regular),
      ],
    );
  }
}

