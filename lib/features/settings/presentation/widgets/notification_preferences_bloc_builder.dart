import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_top_snack_bar.dart';
import '../../../../core/widgets/custom_skeleton_widget.dart';
import '../../../../core/widgets/empty_note_box_widget.dart';
import '../cubit/notification_preferences_cubit.dart';
import '../cubit/notification_preferences_state.dart';
import 'settings_section_card_widget.dart';
import 'settings_switch_tile_widget.dart';

class NotificationPreferencesBlocBuilder extends StatelessWidget {
  const NotificationPreferencesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationPreferencesCubit>();
    final title = 'settings.notifications_section'.tr(context: context);

    return BlocConsumer<
      NotificationPreferencesCubit,
      NotificationPreferencesState
    >(
      listenWhen: (_, current) =>
          current is NotificationPreferencesSuccess && current.failure != null,
      listener: (context, state) {
        if (state case NotificationPreferencesSuccess(:final failure?)) {
          AppTopSnackBar.showError(context, failure.tr(context: context));
        }
      },
      builder: (context, state) {
        return switch (state) {
          NotificationPreferencesSuccess(:final preferences) =>
            SettingsSectionCardWidget(
              title: title,
              children: [
                for (final preference in preferences)
                  SettingsSwitchTileWidget(
                    title: 'settings.categories.${preference.category}.title'
                        .tr(context: context),
                    subtitle: preference.canDisable
                        ? 'settings.categories.${preference.category}.sub'.tr(
                            context: context,
                          )
                        : 'settings.categories.always_on'.tr(context: context),
                    value: preference.inAppEnabled,
                    onChanged: preference.canDisable
                        ? (value) {
                            HapticFeedback.selectionClick();
                            cubit.toggle(preference.category, enabled: value);
                          }
                        : null,
                  ),
              ],
            ),
          NotificationPreferencesError(:final message) => EmptyNoteBoxWidget(
            text: message.tr(context: context),
          ),
          _ => const CustomSkeletonWidget(height: 220),
        };
      },
    );
  }
}
