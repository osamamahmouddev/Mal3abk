class AppApiFailure {
  const AppApiFailure({
    required this.message,
    this.code,
    this.fieldErrors = const {},
    this.nonFieldErrors = const [],
    this.extraData = const {},
  });

  final String message;
  final String? code;
  final Map<String, List<String>> fieldErrors;
  final List<String> nonFieldErrors;
  final Map<String, dynamic> extraData;

  String? fieldMessage(String field) {
    final values = fieldErrors[field];
    if (values == null || values.isEmpty) return null;
    return values.first;
  }
}
