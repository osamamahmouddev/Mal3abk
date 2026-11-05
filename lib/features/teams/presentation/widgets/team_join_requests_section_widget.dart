import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/widgets/custom_card_widget.dart';
import '../../../../core/widgets/section_header_widget.dart';
import '../../data/models/team_join_request_model.dart';
import 'team_join_request_row_widget.dart';

class TeamJoinRequestsSectionWidget extends StatelessWidget {
  const TeamJoinRequestsSectionWidget({required this.requests, super.key});

  final List<TeamJoinRequestModel> requests;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeaderWidget(
          title: 'teams.requests.title'.tr(
            context: context,
            args: [
              requests.length.toLocalizedDigits(context.locale.languageCode),
            ],
          ),
        ),
        hSpace(12),
        CustomCardWidget(
          borderRadius: 18,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (final request in requests)
                TeamJoinRequestRowWidget(request: request),
            ],
          ),
        ),
      ],
    );
  }
}
