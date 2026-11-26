import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../reference/data/models/governorate_model.dart';
import '../../../reference/data/models/localized_item_model.dart';
import '../../../venue_overview/data/models/venue_approval_model.dart';
import '../../../venue_shell/data/models/venue_model.dart';
import '../../../venue_shell/data/models/venue_pitch_model.dart';
import '../../data/models/venue_setup_form.dart';

part 'venue_setup_state.freezed.dart';

@freezed
abstract class VenueSetupState with _$VenueSetupState {
  const factory VenueSetupState({
    /// 1 place, 2 pitches, 3 hours, 4 review.
    @Default(1) int step,

    /// Null until the first save creates it.
    VenueModel? venue,
    VenueApprovalModel? approval,
    @Default([]) List<GovernorateModel> governorates,
    @Default([]) List<LocalizedItemModel> facilities,
    @Default([]) List<LocalizedItemModel> surfaces,
    @Default([]) List<VenuePitchModel> pitches,
    required Map<int, DayHours> week,

    /// Photos uploaded before the venue exists, and while adding a pitch.
    @Default([]) List<String> pendingVenuePhotos,
    @Default([]) List<String> draftPitchPhotos,
    @Default(false) bool saving,
    @Default(false) bool uploading,
    String? error,
  }) = _VenueSetupState;
}

extension VenueSetupStateX on VenueSetupState {
  String get approvalStatus =>
      approval?.approvalStatus ?? venue?.approvalStatus ?? 'Draft';

  bool get canSubmit =>
      approvalStatus == 'Draft' ||
      approvalStatus == 'NeedsInfo' ||
      approvalStatus == 'Rejected';

  /// The platform's last note other than the owner's own submission.
  String? get lastAdminNote => approval?.history
      .where((h) => (h.message?.isNotEmpty ?? false) && h.action != 'Submitted')
      .lastOrNull
      ?.message;

  List<String> get venuePhotos =>
      venue == null ? pendingVenuePhotos : venue!.photos;
}
