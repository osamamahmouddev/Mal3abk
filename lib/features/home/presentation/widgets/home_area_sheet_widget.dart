import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../reference/data/models/governorate_model.dart';
import '../../../reference/presentation/cubit/governorates_cubit.dart';
import '../../../reference/presentation/widgets/governorate_area_picker_bloc_builder.dart';

/// The place the player picked: a governorate code and, optionally, an area.
/// A null city means all of Egypt, unless [nearMe] asks for the player's own
/// location.
typedef PickedArea = ({String? city, String? area, bool nearMe});

/// Bottom sheet for choosing the area the home feed shows.
class HomeAreaSheetWidget extends HookWidget {
  const HomeAreaSheetWidget({this.initialCity, this.initialArea, super.key});

  /// The area the feed shows now, preselected so the player sees it.
  final String? initialCity;
  final String? initialArea;

  static Future<PickedArea?> show(
    BuildContext context, {
    required GovernoratesCubit governorates,
    String? initialCity,
    String? initialArea,
  }) {
    return showModalBottomSheet<PickedArea>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => BlocProvider<GovernoratesCubit>.value(
        value: governorates,
        child: HomeAreaSheetWidget(
          initialCity: initialCity,
          initialArea: initialArea,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final governorate = useValueNotifier<GovernorateModel?>(null);
    final area = useValueNotifier<String?>(null);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.fromLTRB(
        20.w,
        12.h,
        20.w,
        MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.borderInput,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              hSpace(20),
              Text(
                'home.change_area_title'.tr(context: context),
                style: AppTextStyles.font18Bold,
              ),
              hSpace(6),
              Text(
                'home.change_area_subtitle'.tr(context: context),
                style: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(16),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(
                  context,
                ).pop((city: null, area: null, nearMe: true)),
                icon: const Icon(Icons.my_location),
                label: Text('home.use_my_location'.tr(context: context)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.brandNavy,
                  minimumSize: Size.fromHeight(48.h),
                  side: const BorderSide(color: AppColors.borderInput),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ),
              hSpace(16),
              GovernorateAreaPickerBlocBuilder(
                label: 'onboarding.profile_setup.area_label'.tr(
                  context: context,
                ),
                governorate: governorate,
                area: area,
                isRequired: false,
                initialCity: initialCity,
                initialArea: initialArea,
              ),
              hSpace(24),
              CustomButton(
                text: 'home.apply_area'.tr(context: context),
                height: 52.h,
                borderRadius: 14,
                onTap: () => Navigator.of(context).pop((
                  city: governorate.value?.code,
                  area: area.value,
                  nearMe: false,
                )),
              ),
              hSpace(8),
              TextButton(
                onPressed: () => Navigator.of(
                  context,
                ).pop((city: null, area: null, nearMe: false)),
                child: Text(
                  'home.show_all_egypt'.tr(context: context),
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
