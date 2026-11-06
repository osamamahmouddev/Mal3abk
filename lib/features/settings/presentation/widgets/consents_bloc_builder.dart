import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_skeleton_widget.dart';
import '../../../../core/widgets/empty_note_box_widget.dart';
import '../../data/models/record_consent_request_body.dart';
import '../cubit/consents_cubit.dart';
import '../cubit/consents_state.dart';
import 'settings_section_card_widget.dart';
import 'settings_switch_tile_widget.dart';

class ConsentsBlocBuilder extends StatelessWidget {
  const ConsentsBlocBuilder({super.key});

  static const List<ConsentType> shown = [
    ConsentType.location,
    ConsentType.marketing,
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConsentsCubit>();
    final title = 'settings.privacy_section'.tr(context: context);

    return BlocConsumer<ConsentsCubit, ConsentsState>(
      listenWhen: (_, current) =>
          current is ConsentsSuccess && current.failure != null,
      listener: (context, state) {
        if (state case ConsentsSuccess(:final failure?)) {
          AppTopSnackBar.showError(context, failure.tr(context: context));
        }
      },
      builder: (context, state) {
        return switch (state) {
          ConsentsSuccess(:final consents) => SettingsSectionCardWidget(
            title: title,
            children: [
              for (final type in shown)
                SettingsSwitchTileWidget(
                  title: 'settings.consents.${type.name}.title'.tr(
                    context: context,
                  ),
                  subtitle: 'settings.consents.${type.name}.sub'.tr(
                    context: context,
                  ),
                  value: consents.isGranted(type.serverName),
                  onChanged: (value) {
                    HapticFeedback.selectionClick();
                    cubit.set(type, granted: value);
                  },
                ),
            ],
          ),
          ConsentsError(:final message) => EmptyNoteBoxWidget(
            text: message.tr(context: context),
          ),
          _ => const CustomSkeletonWidget(height: 130),
        };
      },
    );
  }
}
