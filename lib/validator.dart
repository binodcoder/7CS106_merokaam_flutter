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

  static validatePassword(String password) {
    if (password.isEmpty) {
      return "Required Field";
    }

    // Password validation pattern:
    // At least one uppercase letter, one lowercase letter, one digit, and one special character.
    // Minimum length is 8 characters.
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';

    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(password)) {
      return "Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character.";
    }

    return null; // Password is strong
  }
}
