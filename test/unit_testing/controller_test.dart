import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/globals/controllers/auth_controller.dart';

void main() {
  group('Test AuthController', () {
    late AuthController authController;
    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      await FirebaseAppCheck.instance.activate();
      authController = Get.put<AuthController>(AuthController());
    });
    test('Test login', () async {
      expect(authController.isLOggedIn.value, false);
      await authController.signIn(
          email: 'invalidemail@gmail.com', password: 'Invalid Password');
      expect(authController.isLOggedIn.value, false);
    });
  });
}
