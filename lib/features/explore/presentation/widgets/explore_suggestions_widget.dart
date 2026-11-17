import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app/app_spaces.dart';
import '../../../../core/extensions/app_display_extensions.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/explore_result_model.dart';
import '../cubit/explore_list_cubit.dart';

/// Ways out of an empty search, as the API suggests them: each button relaxes
/// one filter and says how many venues that brings back.
class ExploreSuggestionsWidget extends StatelessWidget {
  const ExploreSuggestionsWidget({required this.suggestions, super.key});

  final List<ExploreSuggestionModel> suggestions;

  /// Codes the app can apply; others (e.g. any_area) are not shown.
  static const Set<String> supported = {
    'widen_radius',
    'any_time',
    'any_date',
    'any_budget',
    'any_pitch',
    'fewer_facilities',
  };

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;
    final usable = suggestions
        .where((s) => supported.contains(s.code) && s.matchCount > 0)
        .take(3)
        .toList();
    if (usable.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (i, s) in usable.indexed) ...[
          if (i > 0) hSpace(8),
          CustomButton(
            text: 'explore.suggestions.${s.code}'.tr(
              context: context,
              args: [s.matchCount.toLocalizedDigits(lang)],
            ),
            type: i == 0 ? CustomButtonType.primary : CustomButtonType.outline,
            onTap: () {
              HapticFeedback.selectionClick();
              context.read<ExploreListCubit>().applySuggestion(s.code);
            },
          ),
        ],
      ],
    );
  }
}
