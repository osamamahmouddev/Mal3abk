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
typedef PickedArea = ({String city, String? area});

/// Bottom sheet for choosing the area the home feed shows.
class HomeAreaSheetWidget extends HookWidget {
  const HomeAreaSheetWidget({this.initialCity, super.key});

  final String? initialCity;

  static Future<PickedArea?> show(
    BuildContext context, {
    required GovernoratesCubit governorates,
    String? initialCity,
  }) {
    return showModalBottomSheet<PickedArea>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => BlocProvider<GovernoratesCubit>.value(
        value: governorates,
        child: HomeAreaSheetWidget(initialCity: initialCity),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final governorate = useValueNotifier<GovernorateModel?>(null);
    final area = useValueNotifier<String?>(null);
    final canApply = useValueListenable(governorate) != null;

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
              hSpace(20),
              GovernorateAreaPickerBlocBuilder(
                label: 'onboarding.profile_setup.area_label'.tr(
                  context: context,
                ),
                governorate: governorate,
                area: area,
                initialCity: initialCity,
              ),
              hSpace(24),
              CustomButton(
                text: 'home.apply_area'.tr(context: context),
                height: 52.h,
                borderRadius: 14,
                enabled: canApply,
                onTap: () => Navigator.of(
                  context,
                ).pop((city: governorate.value!.code, area: area.value)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
