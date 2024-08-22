class Validator {
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return "Required Field";
    }

    // Email validation pattern
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(email)) {
      return "Invalid Email";
    }

    return null; // Email is valid
  }
}
