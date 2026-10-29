import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/verify_old_phone_bloc_listener.dart';
import '../widgets/verify_old_phone_form_widget.dart';

class VerifyOldPhoneScreen extends StatelessWidget {
  const VerifyOldPhoneScreen({required this.requestId, super.key});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    return VerifyOldPhoneBlocListener(
      requestId: requestId,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'phone_change.title'.tr(context: context),
          subtitle: 'phone_change.verify_old.step'.tr(context: context),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: VerifyOldPhoneFormWidget(requestId: requestId),
          ),
        ),
      ),
    );
  }
}
