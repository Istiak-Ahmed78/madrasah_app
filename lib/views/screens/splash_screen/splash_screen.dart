import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/views/screens/nav_bar/nav_bar.dart';
import 'package:madrasah_app/views/screens/tabs/home_tab/home_tab.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Get.off(() => NavBar());
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
