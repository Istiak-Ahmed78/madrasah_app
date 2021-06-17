import 'package:flutter/material.dart';
import 'package:madrasah_app/views/screens/splash_screen/splash_screen.dart';

import 'views/screens/annoucement_details/announcement_details.dart';
import 'views/screens/see_all_announcements/see_all_announcements.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
