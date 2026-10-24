import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/booking_card_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';

class MyBookingsScreen extends HookWidget {
  const MyBookingsScreen({super.key});

  static const List<String> _tabs = ['القادمة', 'معلّقة', 'المنتهية', 'الملغية'];

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(1); // Default to "معلّقة" as seen in Figma 10:128

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'حجوزاتي',
        showBackButton: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: CustomTabBarWidget(
            tabs: _tabs,
            selectedIndex: selectedTab.value,
            badgeCounts: const {0: 1, 1: 2},
            onTabSelected: (index) => selectedTab.value = index,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          children: [
            BookingCardWidget(
              venueName: 'ملعب النجوم',
              pitchName: 'ملعب ١',
              dateTime: 'السبت ٢٦ يوليو · ٨:٠٠ م – ٩:٠٠ م',
              bookingCode: 'KH-2607-0142',
              status: BookingStatus.pendingReview,
              statusText: 'قيد المراجعة',
              depositRowText: 'إيصال العربون',
              depositAmount: '٥٠ ج.م · مرفوع ٧:٠٩ م',
              noteText: 'الملعب بيراجع التحويل — الرد متوقع قبل ٩:٠٩ م',
              secondaryActionText: 'التفاصيل',
              onSecondaryAction: () => Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
            ),
            BookingCardWidget(
              venueName: 'ملعب المدينة',
              pitchName: 'ملعب ١',
              dateTime: 'الإثنين ٢٨ يوليو · ١٠:٠٠ م – ١١:٠٠ م',
              bookingCode: 'KH-2807-0151',
              status: BookingStatus.rejected,
              statusText: '✕ الإيصال مرفوض',
              depositRowText: 'العربون المطلوب',
              depositAmount: '٦٠ ج.م',
              noteText: 'السبب: المبلغ في الإيصال ٣٠ ج.م بدل ٦٠ ج.م. أعد الرفع خلال ٤٥ دقيقة.',
              primaryActionText: 'أعد رفع الإيصال',
              secondaryActionText: 'التفاصيل',
              onPrimaryAction: () => Navigator.of(context).pushNamed(AppRoutes.proofRejected),
              onSecondaryAction: () => Navigator.of(context).pushNamed(AppRoutes.bookingDetails),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.proofRejected),
            ),
          ],
        ),
      ),
    );
  }
}
