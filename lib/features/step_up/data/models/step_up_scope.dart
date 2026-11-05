/// Server-side step-up scopes; a token is valid only for the scope it was
/// issued for.
class StepUpScope {
  const StepUpScope._();

  static const String changePhone = 'change_phone';
  static const String deleteAccount = 'delete_account';
  static const String exportData = 'export_data';
}
