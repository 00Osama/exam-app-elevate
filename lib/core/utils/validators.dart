import 'package:exam_app_elevate/core/constants/app_strings.dart';

abstract class AppValidators {
  static final RegExp _emailRegex = RegExp(r'^[\w\.\-]+@[\w\-]+\.[a-zA-Z]{2,}$');

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired;
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return AppStrings.emailNotValid;
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    return null;
  }

  static String? username(String? value) {
  if (value == null || value.trim().isEmpty) {
    return AppStrings.usernameRequired;
  }
  return null;
}

static String? name(String? value) {
  if (value == null || value.trim().isEmpty) {
    return AppStrings.nameRequired;
  }
  return null;
}

static String? phone(String? value) {
  if (value == null || value.trim().isEmpty) {
    return AppStrings.phoneRequired;
  }
  if (!RegExp(r'^[0-9]{11}$').hasMatch(value.trim())) {
    return AppStrings.phoneNotValid;
  }
  return null;
}

static String? confirmPassword(String? value, String password) {
  if (value == null || value.isEmpty) {
    return AppStrings.passwordRequired;
  }
  if (value != password) {
    return AppStrings.passwordsNotMatch;
  }
  return null;
}
}