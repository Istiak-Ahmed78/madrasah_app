import 'package:get/get.dart';
import 'package:madrasah_app/globals/controllers/auth_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
