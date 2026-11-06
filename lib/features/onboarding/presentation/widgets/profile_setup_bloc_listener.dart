import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/app_top_snack_bar.dart';
import '../cubit/profile_setup_cubit.dart';
import '../cubit/profile_setup_state.dart';

/// Onboarding continues to the permission steps; editing returns to the
/// profile.
class ProfileSetupBlocListener extends StatelessWidget {
  const ProfileSetupBlocListener({
    required this.isOnboarding,
    required this.child,
    super.key,
  });

  final bool isOnboarding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileSetupCubit, ProfileSetupState>(
      listener: (context, state) {
        switch (state) {
          case ProfileSetupSuccess(:final profile):
            HapticFeedback.mediumImpact();
            if (isOnboarding) {
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.locationPermission);
            } else {
              AppTopSnackBar.showSuccess(
                context,
                'profile.saved'.tr(context: context),
              );
              Navigator.of(context).pop(profile);
            }
          case ProfileSetupError(:final message):
            HapticFeedback.heavyImpact();
            AppTopSnackBar.showError(context, message.tr(context: context));
          default:
            break;
        }
      },
      child: child,
    );
  }
}
