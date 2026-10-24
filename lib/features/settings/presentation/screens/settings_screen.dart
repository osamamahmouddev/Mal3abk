import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingAlerts = useState(true);
    final teamInvites = useState(true);
    final matchResults = useState(true);
    final promotions = useState(false);
    final appearInSearch = useState(true);
    final showPhoneToTeam = useState(true);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBarWidget(title: 'الإعدادات'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('الإشعارات', style: AppTextStyles.font15Bold),
              SizedBox(height: 8.h),
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildSwitchTile('حالة الحجوزات والعربون', 'إشعار بالقبول أو الرفض أو التذكير', bookingAlerts.value, (v) => bookingAlerts.value = v),
                    const Divider(height: 1, color: AppColors.border),
                    _buildSwitchTile('الدعوات والتحديات', 'دعوات الفرق وردود التحديات', teamInvites.value, (v) => teamInvites.value = v),
                    const Divider(height: 1, color: AppColors.border),
                    _buildSwitchTile('النتايج والترتيب', 'تأكيد النتايج وتغيّر الترتيب', matchResults.value, (v) => matchResults.value = v),
                    const Divider(height: 1, color: AppColors.border),
                    _buildSwitchTile('عروض الملاعب', 'محتوى إعلاني وعروض خاصة', promotions.value, (v) => promotions.value = v),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              Text('الخصوصية', style: AppTextStyles.font15Bold),
              SizedBox(height: 8.h),
              CustomCardWidget(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildSwitchTile('اظهر في البحث عن لاعبين', 'الكباتن يقدروا يلاقوك ويدعوك', appearInSearch.value, (v) => appearInSearch.value = v),
                    const Divider(height: 1, color: AppColors.border),
                    _buildSwitchTile('اظهر رقمي لأعضاء فرقي', 'الملعب بيشوف رقمك دايماً للتواصل', showPhoneToTeam.value, (v) => showPhoneToTeam.value = v),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: AppTextStyles.font14SemiBold),
      subtitle: Text(subtitle, style: AppTextStyles.font11Regular),
      value: value,
      activeThumbColor: AppColors.brandNavy,
      onChanged: onChanged,
    );
  }
}
