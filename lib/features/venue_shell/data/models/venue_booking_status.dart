/// Booking statuses as the API sends them (numbers).
abstract final class VenueBookingStatus {
  static const int draft = 1;
  static const int pendingDeposit = 2;
  static const int proofSubmitted = 3;
  static const int underReview = 4;
  static const int confirmed = 5;
  static const int rejected = 6;
  static const int expired = 7;
  static const int cancelled = 8;
  static const int completed = 9;
  static const int noShow = 10;

  static const Map<int, String> keys = {
    draft: 'draft',
    pendingDeposit: 'pending_deposit',
    proofSubmitted: 'proof_submitted',
    underReview: 'under_review',
    confirmed: 'confirmed',
    rejected: 'rejected',
    expired: 'expired',
    cancelled: 'cancelled',
    completed: 'completed',
    noShow: 'no_show',
  };

  /// The key of a status the API names (`Confirmed`, `NoShow`, …).
  static String? keyOfName(String name) => const {
    'Draft': 'draft',
    'PendingDeposit': 'pending_deposit',
    'ProofSubmitted': 'proof_submitted',
    'UnderReview': 'under_review',
    'Confirmed': 'confirmed',
    'Rejected': 'rejected',
    'Expired': 'expired',
    'Cancelled': 'cancelled',
    'Completed': 'completed',
    'NoShow': 'no_show',
  }[name];

  /// Statuses that still hold the slot.
  static const Set<int> active = {
    pendingDeposit,
    proofSubmitted,
    underReview,
    confirmed,
  };
}
