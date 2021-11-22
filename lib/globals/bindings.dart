import 'package:get/get.dart';
import 'package:madrasah_app/globals/controllers/auth_controller.dart';
import 'package:madrasah_app/services/cloud_storage.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(CloudServices());
  }
}
