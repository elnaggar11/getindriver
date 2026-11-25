import 'package:easy_localization/easy_localization.dart';
import 'package:getin_driver/core/localization/localization_helper.dart';
import '../app_strings/locale_keys.dart';
import 'phone_length_by_country.dart';

class Validation {
  String? defaultValidation(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return (LocaleKeys.valid_requiredField.tr());
      }
      //short
      // if (value.length < (3)) //value.length < 3
      // {
      //   return ('shortField'.tr());
      // }
      return null;
    }
    return null;
  }

  static String? phoneValidation(String? value) {
    // String p =r'(^[+]?[(]?[0-9]{3}[)]?[-\s.]?[0-9]{3}[-\s.]?[0-9]{4,6}$)';
    String p = r'^5[0-9]{8}$';

    RegExp regExp = RegExp(p);
    if (value!.trim().isEmpty) {
      return (LocalizationHelper.tr.required_field);
    } else if (!regExp.hasMatch(value.trim())) {
      return (LocalizationHelper.tr.phoneDoseNotMatch);
    } else {
      return null;
    }
  }

  static RegExp emailReg = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  String? emailValidation(String? value) {
    if (value!.trim().isEmpty) {
      return (LocalizationHelper.tr.required_field);
    } else if (!emailReg.hasMatch(value.trim())) {
      return (LocalizationHelper.tr.wrongEmailValidation);
    } else {
      return null;
    }
  }

  String? phoneNumberValidation(String? value) {
    if (value!.isEmpty) {
      return LocalizationHelper.tr.phone_number_is_required;
    }
    if (value.length > 15 || value.length < 7) {
      return LocalizationHelper
          .tr
          .phone_number_should_be_between_7_and_15_characters;
    }
    return null;
  }

  String? Function(String?) phoneValidationByCountry(String dialCode) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return LocalizationHelper.tr.required_field;
      }

      final digitsOnly = value.trim().replaceAll(RegExp(r'\D'), '');
      final rule = phoneLengthRules[dialCode] ?? defaultPhoneLengthRule;
      final numRegExp = RegExp(r'^[0-9]+$');

      if (!numRegExp.hasMatch(value)) {
        return LocalizationHelper.tr.phoneDoseNotMatch;
      }

      if (digitsOnly.length < rule.minLength ||
          digitsOnly.length > rule.maxLength) {
        if (rule.minLength == rule.maxLength) {
          return LocalizationHelper.tr.valid_exactLength(rule.minLength);
        }
        return LocalizationHelper.tr.valid_numberBetween(
          rule.minLength,
          rule.maxLength,
        );
      }

      return null;
    };
  }

  String? passwordValidation(String? value) {
    if (value!.trim().isEmpty) {
      return LocalizationHelper.tr.password_is_required;
    } else if (value.trim().length < 8) {
      return LocalizationHelper.tr.password_should_be_at_least_8_characters;
    } else {
      return null;
    }
  }

  String? confirmPasswordValidation(value, String password) {
    if (value!.isEmpty) {
      return LocalizationHelper.tr.required_field;
    } else if (password != value) {
      return LocalizationHelper.tr.passwords_do_not_match;
    } else {
      return null;
    }
  }

  String? ageValidation(String? value) {
    if (value == null || value.isEmpty) {
      return LocalizationHelper.tr.required_field;
    }
    final date = DateTime.tryParse(value);
    if (date == null) {
      return LocalizationHelper.tr.required_field;
    }
    final today = DateTime.now();
    var age = today.year - date.year;
    if (today.month < date.month ||
        (today.month == date.month && today.day < date.day)) {
      age--;
    }
    if (age < 10) {
      return LocalizationHelper.tr.must_be_at_least_16_years_old('10');
    }
    return null;
  }

  static bool? isValidSaudiPhoneNumber(String input) {
    // Regular expression to match Saudi phone number format
    // Note: This is a simple example and may need adjustment based on actual requirements
    RegExp regex = RegExp(r'^5[0-9]{8}$');
    return regex.hasMatch(input);
  }
}
