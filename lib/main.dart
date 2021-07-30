import 'package:flutter/material.dart';
import 'package:madrasah_app/views/route_management/route.dart';
import 'package:madrasah_app/views/route_management/route_name.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteMangement.generateRoute,
      initialRoute: RouteName.spleshScreen,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
