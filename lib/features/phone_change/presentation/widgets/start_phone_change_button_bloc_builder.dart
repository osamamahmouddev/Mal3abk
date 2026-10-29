import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/start_phone_change_cubit.dart';
import '../cubit/start_phone_change_state.dart';

class StartPhoneChangeButtonBlocBuilder extends StatelessWidget {
  const StartPhoneChangeButtonBlocBuilder({
    required this.phoneController,
    super.key,
  });

  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartPhoneChangeCubit, StartPhoneChangeState>(
      builder: (context, state) {
        return CustomButton(
          text: 'phone_change.send_code'.tr(context: context),
          height: 54.h,
          borderRadius: 16,
          textStyle: AppTextStyles.font17Bold.copyWith(color: AppColors.white),
          isLoading: switch (state) {
            StartPhoneChangeLoading() || StartPhoneChangeSuccess() => true,
            _ => false,
          },
          onTap: () =>
              context.read<StartPhoneChangeCubit>().start(phoneController.text),
        );
      },
    );
  }
}
