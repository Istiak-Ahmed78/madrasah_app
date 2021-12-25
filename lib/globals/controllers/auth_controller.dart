import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/services/auth.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<User?> currentUser = FirebaseAuth.instance.currentUser.obs;
  RxBool isLOggedIn = false.obs;

  static AuthController get to => Get.find();

  @override
  onInit() async {
    isLOggedIn.value = currentUser.value?.uid != null;
    update();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        isLOggedIn.value = false;
        update();
      }
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;
    update();
    try {
      final _user = (await AuthenicationServices.login(email, password))?.user;

      isLoading.value = false;
      isLOggedIn.value = true;
      print('Is logged in ${isLOggedIn.value}');
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      print(e.toString());
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    update();
  }
}
