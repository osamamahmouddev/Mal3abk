import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/app/app_spaces.dart';
import 'phone_change_code_field_widget.dart';
import 'verify_new_phone_button_bloc_builder.dart';

class VerifyNewPhoneFormWidget extends HookWidget {
  const VerifyNewPhoneFormWidget({required this.requestId, super.key});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final codeController = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PhoneChangeCodeFieldWidget(
          description: 'phone_change.verify_new.description'.tr(
            context: context,
          ),
          controller: codeController,
        ),
        hSpace(20),
        VerifyNewPhoneButtonBlocBuilder(
          requestId: requestId,
          codeController: codeController,
        ),
      ],
    );
  }
}
