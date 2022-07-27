import 'consts.dart';

class EmailValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyEmailField;
    }
    // Regex for email validation
    final regExp = RegExp(emailRegex);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return invalidEmailField;
  }
}

class FieldValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyTextField;
    }

    return null;
  }
}

class PasswordValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyPasswordField;
    }

    if (value.length < 6) {
      return passwordLengthError;
    }

    // Regex for dot and comma validation
    final regExp = RegExp(symbolRegex);
    if (regExp.hasMatch(value)) {
      return null;
    }

    return invalidPassword;
  }
}
