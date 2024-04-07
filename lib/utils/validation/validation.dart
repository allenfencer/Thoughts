
class Validation {
  ///[BASIC STRING VALIDATION]
  static String? validateString(String value) {
    if (value.isEmpty) {
      return 'Name field cannot be empty';
    } else {
      return null;
    }
  }

  ///[EMAIL VALIDATION]
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Invalid email format';
    } else {
      return null;
    }
  }

  ///[Email Validation]
   static String? validateEmailwithoutEmpty(String email) {
    if (email.isEmpty) {
      return null;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Invalid email format';
    } else {
      return null;
    }
  }

  ///[DATE OF BIRTH VALIDATION]
  static String? validateSelectedDate(String value) {
    if (value.isEmpty) {
      return 'Enter date of birth';
    } else {
      return null;
    }
  }

  ///[ADDING FUTURE ADMIN VALIDATION]
  static String? validateFutureAdmin(String email) {
    if (email.isEmpty) {
      return null;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Invalid email format';
    } else {
      return null;
    }
  }

  static String? passwordValidation(String password) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (password.isEmpty) {
      return 'Please enter password';
    } else if (!regex.hasMatch(password)) {
      return 'Password strength is too low';
    } else {
      return null;
    }
  }

  static String? matchingPasswordValidation(
      String password1, String password2) {
    if (password1.isEmpty) {
      return 'Please enter a new password first';
    } else if (password1 != password2) {
      return 'Password does not match';
    } else {
      return null;
    }
  }
}
