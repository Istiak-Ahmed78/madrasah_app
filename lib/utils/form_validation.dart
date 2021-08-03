import 'package:email_validator/email_validator.dart';
import '../constants.dart';

class FormValidation {
  static String? validateEmail(String? email) {
    if (email == null || email == '') {
      return 'Email adress is required';
    } else if (!EmailValidator.validate(email)) {
      return 'Enter valid email address';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? password) {
    if (password == null || password == '') {
      return FormValidationErrorMessage.ematyFieldMessage;
    } else if (password.length <= 6) {
      return 'Password length must be at least 6 cherecter';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(bool didMatch) {
    if (!didMatch) {
      return 'Confirm password didn\'t match';
    } else {
      return null;
    }
  }

  static String? validateAdress(value) {
    if (value == null || value == '') {
      return 'Full name field requred';
    } else {
      return null;
    }
  }

  static String? validateNoticeTitle(value) {
    if (value.isEmpty || value == null)
      return 'Please enter a title for this notice.';
    else if (value.length < 6)
      return 'Title length must be getter then 6';
    else if (value.trim() == '')
      return 'Enter a valid title';
    else
      return null;
  }

  static String? valofateFullName(value) {
    if (value == null || value == '') {
      return 'Full name field requred';
    } else if (value.length < 7) {
      return 'Enter your full name';
    } else {
      return null;
    }
  }
}
