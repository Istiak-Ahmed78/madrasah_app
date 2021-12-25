// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:madrasah_app/globals/controllers/auth_controller.dart';
// import 'package:madrasah_app/views/screens/admin_page/admin_page.dart';
// import 'package:madrasah_app/views/screens/profile/logged_in.dart';
// import 'login_screen/login_screen.dart';

// class AuthSensitiveScreen extends StatelessWidget {
//   const AuthSensitiveScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(builder: (controller) {
//       return controller.isLoggedIn()
//           ? controller.isAdminLocal
//               ? const AdminPage()
//               : const ProfilePage()
//           : LogInScreen();
//     });
//     // return authSateProvider.isLoggedIn()
//     //     ? authSateProvider.isAdmin
//     //         ? const AdminPage()
//     //         : const ProfilePage()
//     //     : LogInScreen();
//   }
// }
