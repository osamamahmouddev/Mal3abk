import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_chip_widget.dart';
import '../../../../core/widgets/custom_search_field_widget.dart';
import '../../../../core/widgets/pitch_card_widget.dart';

class ExploreListScreen extends StatefulWidget {
  const ExploreListScreen({super.key});

  @override
  State<ExploreListScreen> createState() => _ExploreListScreenState();
}

class _ExploreListScreenState extends State<ExploreListScreen> {
  int _selectedFilterChip = 0;
  final List<String> _filters = ['الكل', 'قريب مني', 'متاح النهارده', 'نجيل طبيعي', '٥ ضد ٥'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'استكشف الملاعب',
        subtitle: 'القاهرة، مدينة نصر (١٢ ملعب)',
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined, color: AppColors.brandNavy),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.exploreMap),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: CustomSearchFieldWidget(
                hintText: 'ابحث باسم الملعب أو المنطقة...',
                onFilterTap: () => Navigator.of(context).pushNamed(AppRoutes.filtersAndSort),
                hasActiveFilters: true,
              ),
            ),
            SizedBox(
              height: 42.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: _filters.length,
                separatorBuilder: (_, _) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  return CustomChipWidget(
                    label: _filters[index],
                    isSelected: _selectedFilterChip == index,
                    onTap: () => setState(() => _selectedFilterChip = index),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  PitchCardWidget(
                    name: 'ملعب النجوم',
                    specs: 'ملعب ١ · ٥ لاعب · نجيل صناعي · ١٫٢ كم',
                    pricePerHour: '١٥٠ ج.م',
                    rating: 4.8,
                    isFavorite: true,
                    availableSlots: const ['٨:٠٠ م', '١١:٠٠ م', '١٢:٠٠ ص'],
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.venueProfile),
                    onSlotTap: (slot) => Navigator.of(context).pushNamed(AppRoutes.pitchAndTime),
                  ),
                  PitchCardWidget(
                    name: 'أكاديمية الدلتا',
                    specs: 'ملعب ٢ · ٧ لاعب · إضاءة ليد · ٢٫٥ كم',
                    pricePerHour: '٢٠٠ ج.م',
                    rating: 4.6,
                    availableSlots: const ['٩:٠٠ م', '١٠:٠٠ م'],
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.venueProfile),
                    onSlotTap: (slot) => Navigator.of(context).pushNamed(AppRoutes.pitchAndTime),
                  ),
                  PitchCardWidget(
                    name: 'ملعب المدينة',
                    specs: 'ملعب ١ · ٥ لاعب · مكيف كافيتريا · ٨٠٠ م',
                    pricePerHour: '١٨٠ ج.م',
                    rating: 4.7,
                    availableSlots: const ['٧:٠٠ م', '١٠:٠٠ م'],
                    onTap: () => Navigator.of(context).pushNamed(AppRoutes.venueProfile),
                    onSlotTap: (slot) => Navigator.of(context).pushNamed(AppRoutes.pitchAndTime),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
