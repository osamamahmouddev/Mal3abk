import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/widgets/info_note_card_widget.dart';
import '../../../../core/widgets/phone_prefix_widget.dart';
import 'start_phone_change_button_bloc_builder.dart';

class ChangePhoneFormWidget extends HookWidget {
  const ChangePhoneFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InfoNoteCardWidget(
          title: 'phone_change.how_it_works_title'.tr(context: context),
          body: 'phone_change.how_it_works_body'.tr(context: context),
        ),
        hSpace(20),
        CustomTextFormField(
          controller: phoneController,
          labelText: 'phone_change.new_phone_label'.tr(context: context),
          hintText: '01012345678',
          keyboardType: TextInputType.phone,
          style: AppTextStyles.font17Regular,
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w,
            vertical: 15.h,
          ),
          prefixIcon: const PhonePrefixWidget(),
        ),
        hSpace(20),
        StartPhoneChangeButtonBlocBuilder(phoneController: phoneController),
      ],
    );
  }
}
