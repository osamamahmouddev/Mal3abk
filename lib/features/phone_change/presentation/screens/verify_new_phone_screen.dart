import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/verify_new_phone_bloc_listener.dart';
import '../widgets/verify_new_phone_form_widget.dart';

class VerifyNewPhoneScreen extends StatelessWidget {
  const VerifyNewPhoneScreen({required this.requestId, super.key});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    return VerifyNewPhoneBlocListener(
      requestId: requestId,
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'phone_change.title'.tr(context: context),
          subtitle: 'phone_change.verify_new.step'.tr(context: context),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: VerifyNewPhoneFormWidget(requestId: requestId),
          ),
        ),
      ),
    );
  }
}
