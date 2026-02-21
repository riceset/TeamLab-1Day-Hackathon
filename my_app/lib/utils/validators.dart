import '../constants/app_constants.dart';

class Validators {
  static String? required(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  static String? titleValidator(String? value) {
    return required(value, AppStrings.titleRequired);
  }

  static String? detailValidator(String? value) {
    return required(value, AppStrings.detailRequired);
  }

  static String? dateValidator(String? value) {
    return required(value, AppStrings.dateRequired);
  }
}
