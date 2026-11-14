import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/reference/presentation/cubit/governorates_cubit.dart';
import '../../features/reference/presentation/cubit/governorates_state.dart';
import '../utils/location_names.dart';

extension PlaceNameExtension on BuildContext {
  /// A readable, localized "area, city" for the codes the API stores
  /// (`nasr_city`, `cairo`), from the app-wide governorates list.
  String placeName({String? city, String? area}) {
    final governorates = select<GovernoratesCubit, GovernoratesState>(
      (cubit) => cubit.state,
    );
    return LocationNames.display(
      languageCode: locale.languageCode,
      governorates: switch (governorates) {
        GovernoratesSuccess(:final governorates) => governorates,
        _ => const [],
      },
      city: city,
      area: area,
    );
  }
}
