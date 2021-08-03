import 'package:flutter/material.dart';
import 'package:madrasah_app/state_management/auth_state.dart';
import 'package:madrasah_app/views/screens/admin_page/admin_page.dart';
import 'package:madrasah_app/views/screens/profile/logged_in.dart';
import 'package:provider/provider.dart';
import 'login_screen/login_screen.dart';

class AuthSensitiveScreen extends StatelessWidget {
  const AuthSensitiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authSateProvider = Provider.of<AuthState>(context);
    return authSateProvider.isLoggedIn()
        ? authSateProvider.isAdmin
            ? const AdminPage()
            : const ProfilePage()
        : LogInScreen();
  }
}
