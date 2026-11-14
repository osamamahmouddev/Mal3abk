import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_state_widget.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'profile_header_card_widget.dart';
import 'profile_header_skeleton_widget.dart';

class ProfileHeaderBlocBuilder extends StatelessWidget {
  const ProfileHeaderBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) => switch (state) {
        ProfileSuccess(:final overview) => ProfileHeaderCardWidget(
          overview: overview,
        ),
        ProfileError(:final message) => CustomStateWidget(
          title: message.tr(context: context),
          description: '',
          actionText: 'common.retry'.tr(context: context),
          onActionTap: context.read<ProfileCubit>().fetchProfile,
        ),
        _ => const ProfileHeaderSkeletonWidget(),
      },
    );
  }
}
