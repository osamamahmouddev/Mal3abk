import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class CreateTeamScreen extends HookWidget {
  const CreateTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teamNameController = useTextEditingController();
    final areaController = useTextEditingController();
    final isPublic = useState(true);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'teams.create_team_title'.tr(context: context),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomButton(
            text: 'teams.create_team_title'.tr(context: context),
            type: CustomButtonType.primary,
            height: 52.h,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                controller: teamNameController,
                labelText: 'اسم الفريق *',
                hintText: 'مثال: نسور الشرق',
              ),
              hSpace(16),
              CustomTextFormField(
                controller: areaController,
                labelText: 'المنطقة الأساسية للعب *',
                hintText: 'مدينة نصر، القاهرة',
              ),
              hSpace(20),
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('فريق عام (يظهر في البحث)', style: AppTextStyles.font14Bold),
                          hSpace(2),
                          Text('يقدر أي كابتن في منطقتك يبعت لفريقك تحديات ومباريات.', style: AppTextStyles.font12Regular),
                        ],
                      ),
                    ),
                    Switch(
                      value: isPublic.value,
                      activeThumbColor: AppColors.brandNavy,
                      onChanged: (val) => isPublic.value = val,
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
