import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:madrasah_app/di_contailer.dart';
import 'package:madrasah_app/state_management/auth_state.dart';
import 'package:madrasah_app/utils/auth_repos/auth_repos.dart';
import 'package:madrasah_app/views/screens/nav_bar/nav_bar.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () async {
      User? currentUser = services<AuthRepos>().getCurrentUser();
      if (currentUser != null) {
        await Provider.of<AuthState>(context, listen: false)
            .getAdminStatus(currentUser.email);
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NavBar()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('L  O  A  D  I  N  G'),
      ),
    );
  }
}
