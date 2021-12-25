import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/services/auth.dart';
import 'package:madrasah_app/views/screens/auth/log_in/log_in_screen.dart';
import 'package:madrasah_app/views/screens/tabs/home_tab/home_tab.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<User?> currentUser = FirebaseAuth.instance.currentUser.obs;
  RxBool get isLOggedIn => (currentUser.value != null).obs;

  static AuthController get to => Get.find();

  @override
  onInit() async {
    User? user = ;
    currentUser.value = user;
    update();
    ever<bool>(isLOggedIn, (data) {
      print(data);
      if (data) {
        Get.off(HomePage());
      } else {
        Get.off(LogInScreen());
      }
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;
    update();
    try {
      currentUser.value =
          (await AuthenicationServices.login(email, password))?.user;
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }

    isLoading.value = false;
    update();
  }

  User? getCurrentUsercheck() => FirebaseAuth.instance.currentUser;
}
