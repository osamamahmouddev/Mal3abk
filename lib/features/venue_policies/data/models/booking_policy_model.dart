/// The venue's booking policy (`BookingPolicySnapshot`), kept as the
/// `BookingPolicyApiRequest` body so options can patch it.
class BookingPolicyModel {
  const BookingPolicyModel(this.values, {this.version});

  /// API request field → value (enums as their numbers).
  final Map<String, Object?> values;
  final int? version;

  static const Map<String, Object?> defaults = {
    'depositType': 0,
    'depositValue': 33,
    'proofSubmissionWindowMinutes': 30,
    'manualReviewWindowMinutes': 60,
    'pendingBookingsBlockSlots': true,
    'cancellationDeadlineHours': 24,
    'refundEligibility': 0,
    'refundPercentage': 100,
    'noShowRule': 0,
    'lateArrivalGraceMinutes': 15,
    'allowReschedule': true,
    'rescheduleDeadlineHours': 24,
    'terms': null,
  };

  static const _deposit = {'Percentage': 0, 'FixedAmount': 1, 'Full': 2};
  static const _refund = {'FullRefund': 0, 'PartialRefund': 1, 'NoRefund': 2};
  static const _noShow = {
    'ForfeitDeposit': 0,
    'ForfeitFullAmount': 1,
    'NoPenalty': 2,
  };

  /// The current version from `GET booking-policy` (a list of versions).
  static BookingPolicyModel fromVersions(Object? json) {
    final list = json is List ? json : const [];
    final current =
        list
            .whereType<Map>()
            .where((v) => v['isCurrent'] == true)
            .firstOrNull ??
        list.whereType<Map>().lastOrNull;
    final snapshot = current?['policy'];
    if (snapshot is! Map) return const BookingPolicyModel(defaults);
    num n(String key) => (snapshot[key] as num?) ?? (defaults[key] as num);
    return BookingPolicyModel({
      'depositType': _deposit[snapshot['depositType']] ?? 0,
      'depositValue': n('depositValue'),
      'proofSubmissionWindowMinutes': n('proofSubmissionWindowMinutes'),
      'manualReviewWindowMinutes': n('manualReviewWindowMinutes'),
      'pendingBookingsBlockSlots':
          snapshot['pendingBookingsBlockSlots'] as bool? ?? true,
      'cancellationDeadlineHours': n('cancellationDeadlineHours'),
      'refundEligibility': _refund[snapshot['refundEligibility']] ?? 0,
      'refundPercentage': n('refundPercentage'),
      'noShowRule': _noShow[snapshot['noShowRule']] ?? 0,
      'lateArrivalGraceMinutes': n('lateArrivalGraceMinutes'),
      'allowReschedule': snapshot['allowReschedule'] as bool? ?? true,
      'rescheduleDeadlineHours': n('rescheduleDeadlineHours'),
      'terms': snapshot['terms'],
    }, version: (current?['version'] as num?)?.toInt());
  }

  bool matches(Map<String, Object?> patch) =>
      patch.entries.every((e) => values[e.key] == e.value);

  BookingPolicyModel patch(Map<String, Object?> patch) =>
      BookingPolicyModel({...values, ...patch}, version: version);

  Map<String, dynamic> toJson() => Map<String, dynamic>.of(values);
}

/// One choice row of the policy page: a title key, a hint key and its
/// options (label key → fields it sets), like the web page.
class PolicyOptionGroup {
  const PolicyOptionGroup(this.key, this.options);

  final String key;
  final List<(String, Map<String, Object?>)> options;

  static const List<(String, List<PolicyOptionGroup>)> sections = [
    (
      'deposit',
      [
        PolicyOptionGroup('proof_window', [
          ('minutes_15', {'proofSubmissionWindowMinutes': 15}),
          ('minutes_30', {'proofSubmissionWindowMinutes': 30}),
          ('hour', {'proofSubmissionWindowMinutes': 60}),
        ]),
        PolicyOptionGroup('review_window', [
          ('minutes_30', {'manualReviewWindowMinutes': 30}),
          ('hour', {'manualReviewWindowMinutes': 60}),
          ('hours_3', {'manualReviewWindowMinutes': 180}),
        ]),
        PolicyOptionGroup('pending_blocks', [
          ('yes', {'pendingBookingsBlockSlots': true}),
          ('no', {'pendingBookingsBlockSlots': false}),
        ]),
      ],
    ),
    (
      'cancellation',
      [
        PolicyOptionGroup('free_cancel', [
          ('hours_6', {'cancellationDeadlineHours': 6}),
          ('hours_12', {'cancellationDeadlineHours': 12}),
          ('hours_24', {'cancellationDeadlineHours': 24}),
          ('days_2', {'cancellationDeadlineHours': 48}),
        ]),
        PolicyOptionGroup('refund', [
          ('refund_full', {'refundEligibility': 0, 'refundPercentage': 100}),
          ('refund_half', {'refundEligibility': 1, 'refundPercentage': 50}),
          ('refund_none', {'refundEligibility': 2, 'refundPercentage': 0}),
        ]),
      ],
    ),
    (
      'attendance',
      [
        PolicyOptionGroup('no_show', [
          ('no_show_deposit', {'noShowRule': 0}),
          ('no_show_full', {'noShowRule': 1}),
          ('no_show_none', {'noShowRule': 2}),
        ]),
        PolicyOptionGroup('late', [
          ('minutes_10', {'lateArrivalGraceMinutes': 10}),
          ('minutes_15', {'lateArrivalGraceMinutes': 15}),
          ('minutes_30', {'lateArrivalGraceMinutes': 30}),
        ]),
        PolicyOptionGroup('reschedule', [
          (
            'reschedule_no',
            {'allowReschedule': false, 'rescheduleDeadlineHours': 0},
          ),
          (
            'reschedule_12',
            {'allowReschedule': true, 'rescheduleDeadlineHours': 12},
          ),
          (
            'reschedule_24',
            {'allowReschedule': true, 'rescheduleDeadlineHours': 24},
          ),
        ]),
      ],
    ),
  ];

  /// The label key of the option [policy] matches, or null.
  static String? selected(BookingPolicyModel policy, String groupKey) {
    for (final (_, groups) in sections) {
      for (final g in groups) {
        if (g.key != groupKey) continue;
        for (final (label, patch) in g.options) {
          if (policy.matches(patch)) return label;
        }
      }
    }
    return null;
  }
}
