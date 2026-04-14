class Validators {
  static String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final requiredError = validateRequired(value);
    if (requiredError != null) {
      return requiredError;
    }
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.[A-Za-z]{2,}$');
    if (!emailRegex.hasMatch(value!.trim())) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final requiredError = validateRequired(value);
    if (requiredError != null) {
      return requiredError;
    }
    if (value!.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    final requiredError = validateRequired(value);
    if (requiredError != null) {
      return requiredError;
    }
    final phoneRegex = RegExp(r'^\+[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value!.trim())) {
      return 'Enter a valid phone number starting with +.';
    }
    return null;
  }

  static String? validatePasswordMatch(
    String? password,
    String? confirmPassword,
  ) {
    final requiredError = validateRequired(confirmPassword);
    if (requiredError != null) {
      return requiredError;
    }
    if (password != confirmPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }

  static String? validateZipCode(String? value) {
    final requiredError = validateRequired(value);
    if (requiredError != null) {
      return requiredError;
    }
    if (!RegExp(r'^\d{5}$').hasMatch(value!.trim())) {
      return 'Zip code must be 5 digits.';
    }
    return null;
  }
}
