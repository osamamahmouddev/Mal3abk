class AppRegex {
  const AppRegex._();

  static bool isEmailValid(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return password.length >= 6;
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(01[0125][0-9]{8}|[0-9]{9,15})$').hasMatch(phoneNumber);
  }
}
