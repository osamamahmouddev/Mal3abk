import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_card_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _bookingAlerts = true;
  bool _teamInvites = true;
  bool _matchResults = true;
  bool _promotions = false;
  bool _appearInSearch = true;
  bool _showPhoneToTeam = true;

  @override
  Widget build(BuildContext context) {
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
                    _buildSwitchTile('حالة الحجوزات والعربون', 'إشعار بالقبول أو الرفض أو التذكير', _bookingAlerts, (v) => setState(() => _bookingAlerts = v)),
                    const Divider(height: 1, color: AppColors.border),
                    _buildSwitchTile('الدعوات والتحديات', 'دعوات الفرق وردود التحديات', _teamInvites, (v) => setState(() => _teamInvites = v)),
                    const Divider(height: 1, color: AppColors.border),
                    _buildSwitchTile('النتايج والترتيب', 'تأكيد النتايج وتغيّر الترتيب', _matchResults, (v) => setState(() => _matchResults = v)),
                    const Divider(height: 1, color: AppColors.border),
                    _buildSwitchTile('عروض الملاعب', 'محتوى إعلاني وعروض خاصة', _promotions, (v) => setState(() => _promotions = v)),
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
                    _buildSwitchTile('اظهر في البحث عن لاعبين', 'الكباتن يقدروا يلاقوك ويدعوك', _appearInSearch, (v) => setState(() => _appearInSearch = v)),
                    const Divider(height: 1, color: AppColors.border),
                    _buildSwitchTile('اظهر رقمي لأعضاء فرقي', 'الملعب بيشوف رقمك دايماً للتواصل', _showPhoneToTeam, (v) => setState(() => _showPhoneToTeam = v)),
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
