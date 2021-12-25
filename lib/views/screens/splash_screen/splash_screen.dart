import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/globals/controllers/auth_controller.dart';
import 'package:madrasah_app/views/screens/auth/log_in/log_in_screen.dart';
import 'package:madrasah_app/views/screens/nav_bar/nav_bar.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
        init: AuthController(),
        builder: (authController) {
          if (authController.isLOggedIn.value) {
            return NavBar();
          } else {
            return LogInScreen();
          }
        });
  }
}
