import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/create_team_bloc_listener.dart';
import '../widgets/create_team_form_widget.dart';

class CreateTeamScreen extends StatelessWidget {
  const CreateTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateTeamBlocListener(
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: CustomAppBarWidget(
          title: 'teams.create.title'.tr(context: context),
          isClose: true,
        ),
        body: const CreateTeamFormWidget(),
      ),
    );
  }
}
