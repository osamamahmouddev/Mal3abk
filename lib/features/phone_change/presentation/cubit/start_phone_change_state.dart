import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/start_phone_change_response_model.dart';

part 'start_phone_change_state.freezed.dart';

@freezed
class StartPhoneChangeState with _$StartPhoneChangeState {
  const factory StartPhoneChangeState.initial() = StartPhoneChangeInitial;
  const factory StartPhoneChangeState.loading() = StartPhoneChangeLoading;
  const factory StartPhoneChangeState.success(
    StartPhoneChangeResponseModel data,
  ) = StartPhoneChangeSuccess;
  const factory StartPhoneChangeState.error(String message) =
      StartPhoneChangeError;
}
