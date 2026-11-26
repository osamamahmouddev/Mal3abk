import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/app_back_button_widget.dart';
import '../../../../core/widgets/brand_wordmark_widget.dart';
import '../cubit/owner_register_cubit.dart';
import '../cubit/owner_register_state.dart';
import '../widgets/owner_register_done_widget.dart';
import '../widgets/owner_register_form_widget.dart';

/// A venue owner creates an account from the app, the same request the venue
/// web sign-up sends; the activation link then arrives by text message.
class OwnerRegisterScreen extends StatelessWidget {
  const OwnerRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
          child: BlocBuilder<OwnerRegisterCubit, OwnerRegisterState>(
            buildWhen: (a, b) =>
                (a is OwnerRegisterSuccess) != (b is OwnerRegisterSuccess),
            builder: (context, state) {
              final done = state is OwnerRegisterSuccess;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppBackButtonWidget(),
                  ),
                  hSpace(12),
                  BrandWordmarkWidget(height: 38.h),
                  hSpace(22),
                  Text(
                    (done
                            ? 'venue_auth.register.done_title'
                            : 'venue_auth.register.title')
                        .tr(context: context),
                    style: AppTextStyles.font24Bold,
                    textAlign: TextAlign.center,
                  ),
                  hSpace(8),
                  if (done)
                    const OwnerRegisterDoneWidget()
                  else ...[
                    Text(
                      'venue_auth.register.subtitle'.tr(context: context),
                      style: AppTextStyles.font14Regular,
                      textAlign: TextAlign.center,
                    ),
                    hSpace(22),
                    const OwnerRegisterFormWidget(),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
