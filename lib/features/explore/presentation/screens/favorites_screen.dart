import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/pitch_card_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'explore.favorites_title'.tr(context: context),
        subtitle: '٣ ملاعب محفوظة',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: [
            PitchCardWidget(
              name: 'ملعب النجوم',
              specs: 'مدينة نصر · ١٫٢ كم · ٣ ملاعب',
              pricePerHour: '١٥٠ ج.م',
              rating: 4.8,
              isFavorite: true,
              availableSlots: const ['٩:٠٠ م', '١١:٠٠ م'],
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.venueProfile),
            ),
            PitchCardWidget(
              name: 'أكاديمية الدلتا',
              specs: 'مدينة نصر · ٢٫٥ كم · ٢ ملعب',
              pricePerHour: '٢٠٠ ج.م',
              rating: 4.6,
              isFavorite: true,
              availableSlots: const ['٨:٠٠ م'],
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.venueProfile),
            ),
            PitchCardWidget(
              name: 'نادي الشباب',
              specs: 'مدينة نصر · ٢٫٠ كم · ٢ ملعب',
              pricePerHour: '١٦٠ ج.م',
              rating: 4.1,
              isFavorite: true,
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.venueProfile),
            ),
          ],
        ),
      ),
    );
  }
}
