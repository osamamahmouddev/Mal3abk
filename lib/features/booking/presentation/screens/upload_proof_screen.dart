import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_shadows.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/upload_proof_form_widget.dart';
import '../widgets/upload_proof_submitted_widget.dart';

class UploadProofScreen extends HookWidget {
  const UploadProofScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hasFile = useState(false);
    final confirmed = useState(false);
    final isSubmitted = useState(false);
    final ready = hasFile.value && confirmed.value;

    if (isSubmitted.value) {
      return const Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(child: UploadProofSubmittedWidget()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBarWidget(
        title: 'booking.upload_proof_title'.tr(context: context),
      ),
      bottomNavigationBar: BottomActionBarWidget(
        child: CustomButton(
          text: 'booking.upload.submit'.tr(context: context),
          height: 52.h,
          borderRadius: 16,
          backgroundColor: ready ? AppColors.brandRed : AppColors.border,
          boxShadow: ready ? AppShadows.redGlow : null,
          textStyle: AppTextStyles.font16Bold.copyWith(
            color: ready ? AppColors.white : AppColors.mapLabel,
          ),
          onTap: () {
            if (!ready) {
              AppTopSnackBar.showError(
                context,
                'booking.upload.missing'.tr(context: context),
              );
              return;
            }
            isSubmitted.value = true;
          },
        ),
      ),
      body: UploadProofFormWidget(
        hasFile: hasFile.value,
        confirmed: confirmed.value,
        onPickFile: () => hasFile.value = true,
        onConfirmChanged: (value) => confirmed.value = value,
      ),
    );
  }
}
