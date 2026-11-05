import 'team_join_request_model.dart';
import 'team_profile_model.dart';

class TeamDashboardModel {
  const TeamDashboardModel({
    required this.profile,
    this.pendingJoinRequests = const [],
  });

  final TeamProfileModel profile;
  final List<TeamJoinRequestModel> pendingJoinRequests;
}
