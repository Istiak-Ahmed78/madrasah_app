import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/services/auth.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  User? currentUser;

  RxBool isLoggedIn = false.obs;

  static AuthController get to => Get.find();

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;
    update();
    var gottenResponse =
        (await AuthenicationServices.login(email, password)).user;
    if (gottenResponse.runtimeType == User) {
      currentUser = gottenResponse;
    } else {
      Get.snackbar('Error', gottenResponse);
    }
    isLoading.value = false;
    update();
  }
}
