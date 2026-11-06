/// A player booking summary as the API returns it.
Map<String, dynamic> summaryJson(int status) => {
  'id': 'b-1',
  'reference': 'MLB-1001',
  'venueId': 'v-1',
  'pitchId': 'p-1',
  'startUtc': '2026-11-06T17:00:00Z',
  'endUtc': '2026-11-06T18:00:00Z',
  'totalPrice': 400,
  'depositAmount': 100,
  'currency': 'EGP',
  'status': status,
  'allowedActions': {
    'canUploadProof': false,
    'canCancel': true,
    'canReview': false,
  },
  'createdAtUtc': '2026-11-05T10:00:00Z',
  'venueName': 'ملعب النجوم',
  'pitchName': 'ملعب ١',
};
