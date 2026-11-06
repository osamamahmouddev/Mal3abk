import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/bottom_action_bar_widget.dart';
import '../../../../core/widgets/primary_cta_button_widget.dart';
import '../cubit/profile_setup_cubit.dart';
import '../cubit/profile_setup_state.dart';

class ProfileSetupSubmitBlocBuilder extends StatelessWidget {
  const ProfileSetupSubmitBlocBuilder({
    required this.isOnboarding,
    required this.onSubmit,
    super.key,
  });

  final bool isOnboarding;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return BottomActionBarWidget(
      child: BlocBuilder<ProfileSetupCubit, ProfileSetupState>(
        builder: (context, state) => PrimaryCtaButtonWidget(
          text: (isOnboarding ? 'onboarding.profile_setup.next' : 'common.save')
              .tr(context: context),
          isLoading:
              state is ProfileSetupLoading || state is ProfileSetupSuccess,
          onTap: onSubmit,
        ),
      ),
    );
  }
}
