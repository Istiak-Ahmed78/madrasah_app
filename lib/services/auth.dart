import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/utils/methods.dart';

class AuthenicationServices {
  static Future<UserCredential?> login(String email, String password) async {
    try {
      var d = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return d;
    } catch (e) {
      // print();
      // AuthResultStatus status = AuthResultStatus.undefined;
      // switch (e.toString()) {
      //   case "ERROR_INVALID_EMAIL":
      //     status = AuthResultStatus.invalidEmail;
      //     break;
      //   case "ERROR_WRONG_PASSWORD":
      //     status = AuthResultStatus.wrongPassword;
      //     break;
      //   case "ERROR_USER_NOT_FOUND":
      //     status = AuthResultStatus.userNotFound;
      //     break;
      //   case "ERROR_USER_DISABLED":
      //     status = AuthResultStatus.userDisabled;
      //     break;
      //   case "ERROR_TOO_MANY_REQUESTS":
      //     status = AuthResultStatus.tooManyRequests;
      //     break;
      //   case "ERROR_OPERATION_NOT_ALLOWED":
      //     status = AuthResultStatus.operationNotAllowed;
      //     break;
      //   case "ERROR_EMAIL_ALREADY_IN_USE":
      //     status = AuthResultStatus.emailAlreadyExists;
      //     break;
      //   default:
      //     status = AuthResultStatus.undefined;
      // }

      Get.snackbar('Erorr', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
