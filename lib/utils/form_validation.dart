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
}
