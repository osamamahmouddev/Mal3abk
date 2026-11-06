import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/biometric_lock_cubit.dart';
import '../cubit/biometric_lock_state.dart';
import 'settings_switch_tile_widget.dart';

class BiometricLockBlocBuilder extends StatelessWidget {
  const BiometricLockBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BiometricLockCubit, BiometricLockState>(
      builder: (context, state) {
        if (state is! BiometricLockReady) return const SizedBox.shrink();
        return SettingsSwitchTileWidget(
          title: 'settings.biometric.title'.tr(context: context),
          subtitle: 'settings.biometric.sub'.tr(context: context),
          value: state.enabled,
          onChanged: (value) {
            HapticFeedback.selectionClick();
            context.read<BiometricLockCubit>().setEnabled(
              enabled: value,
              reason: 'auth.lock.reason'.tr(context: context),
            );
          },
        );
      },
    );
  }
}
