import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/services/auth.dart';
import 'package:madrasah_app/views/screens/tabs/account_tab/login_screen/login_screen.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<User?> currentUser = null.obs;

  RxBool isLoggedIn = false.obs;

  static AuthController get to => Get.find();

  void onInit() {
    super.onInit();
    check();
    ever(currentUser, (_) {
      if (currentUser.value == null) {
        Get.off(() => LogInScreen());
      }
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;
    update();
    User? gottenUser;
    try {
      gottenUser = (await AuthenicationServices.login(email, password))?.user;
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
    if (gottenUser != null) {
      currentUser.value = gottenUser;
      update();
    }

    isLoading.value = false;
    update();
  }

  Future check() async {
    currentUser.value = FirebaseAuth.instance.currentUser;
    update();
  }
}
