import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mal3abk/features/teams/presentation/cubit/team_action_type.dart';

/// Every team message the app can show must exist in both languages, or the
/// player sees a raw key such as `errors.teams.roster_full`.
void main() {
  Map<String, dynamic> load(String lang) =>
      jsonDecode(File('assets/translations/$lang.json').readAsStringSync())
          as Map<String, dynamic>;

  Object? lookup(Map<String, dynamic> json, String key) {
    Object? node = json;
    for (final part in key.split('.')) {
      if (node is! Map<String, dynamic>) return null;
      node = node[part];
    }
    return node;
  }

  final ar = load('ar');
  final en = load('en');

  const keys = [
    'errors.teams.not_found',
    'errors.teams.invalid_name',
    'errors.teams.invalid_location',
    'errors.teams.name_already_exists',
    'errors.teams.player_already_in_team',
    'errors.teams.player_not_in_team',
    'errors.teams.member_not_found',
    'errors.teams.not_captain',
    'errors.teams.not_captain_or_vice_captain',
    'errors.teams.not_authorized_to_manage_roster',
    'errors.teams.cannot_remove_captain',
    'errors.teams.self_removal_must_transfer_captaincy',
    'errors.teams.cannot_change_captain_role',
    'errors.teams.invalid_invite_code',
    'errors.teams.invite_code_expired',
    'errors.teams.cannot_transfer_to_self',
    'errors.teams.not_recruiting',
    'errors.teams.roster_full',
    'errors.teams.max_player_teams_exceeded',
    'errors.teams.duplicate_join_request',
    'errors.teams.join_request_not_found',
    'errors.teams.join_request_already_handled',
    'errors.teams.suspended',
    'errors.teams.removed_from_team',
    'errors.teams.invalid_role',
    'errors.teams.invite_code_unavailable',
    'teams.manage.make_vice',
    'teams.manage.make_vice_desc',
    'teams.manage.make_member',
    'teams.manage.make_member_desc',
    'teams.manage.disband',
    'teams.manage.disband_title',
    'teams.manage.disband_desc',
    'teams.actions.makeViceCaptain',
    'teams.actions.makeMember',
    'teams.actions.disbandTeam',
    'errors.teams.settings_not_saved',
    'teams.invite.new_code',
    'teams.invite.new_code_title',
    'teams.invite.new_code_desc',
    'errors.forbidden',
    'errors.not_found',
    'errors.conflict',
  ];

  // The action listener shows `teams.actions.<type>` after every success.
  for (final type in TeamActionType.values) {
    test('teams.actions.${type.name} exists in Arabic and English', () {
      for (final (lang, json) in [('ar', ar), ('en', en)]) {
        final value = lookup(json, 'teams.actions.${type.name}');
        expect(value, isA<String>(), reason: '${type.name} missing in $lang');
      }
    });
  }

  for (final key in keys) {
    test('$key exists in Arabic and English', () {
      for (final (lang, json) in [('ar', ar), ('en', en)]) {
        final value = lookup(json, key);
        expect(value, isA<String>(), reason: '$key missing in $lang.json');
        expect((value! as String).trim(), isNotEmpty, reason: '$lang $key');
      }
    });
  }
}
