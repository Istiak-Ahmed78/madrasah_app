import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/globals/bindings.dart';
import 'package:madrasah_app/views/route_management/route.dart';
import 'package:madrasah_app/views/route_management/route_name.dart';

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
      onGenerateRoute: RouteMangement.generateRoute,
      initialRoute: RouteName.spleshScreen,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
