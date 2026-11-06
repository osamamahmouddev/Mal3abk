import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main_shell/presentation/widgets/main_shell_scope_widget.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'profile_nav_tile_widget.dart';

class ProfileTeamsTileBlocBuilder extends StatelessWidget {
  const ProfileTeamsTileBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) => ProfileNavTileWidget(
        icon: Icons.groups_outlined,
        title: 'profile.my_teams'.tr(context: context),
        trailing: state is ProfileSuccess && state.overview.teamNames.isNotEmpty
            ? state.overview.teamNames.take(2).join(' · ')
            : '',
        onTap: () => MainShellScopeWidget.switchTab(
          context,
          MainShellScopeWidget.teamsTab,
        ),
      ),
    );
  }
}
