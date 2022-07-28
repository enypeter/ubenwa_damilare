import 'consts.dart';

class EmailValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return emptyEmailField;
    }
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

    final regdotExp = RegExp(dotRegex);
    final regcommaExp = RegExp(commaRegex);
    if (regdotExp.hasMatch(value) && regcommaExp.hasMatch(value)) {
      return null;
    }

    return invalidPassword;
  }
}
