import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/globals/bindings.dart';
import 'package:madrasah_app/views/screens/auth/log_in/log_in_screen.dart';
import 'package:madrasah_app/views/screens/splash_screen/splash_screen.dart';
import 'package:madrasah_app/views/screens/tabs/tabs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: GlobalBindings(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
