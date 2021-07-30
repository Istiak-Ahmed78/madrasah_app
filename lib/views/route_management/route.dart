import 'package:flutter/material.dart';
import 'package:madrasah_app/views/route_management/route_name.dart';
import 'package:madrasah_app/views/screens/nav_bar/nav_bar.dart';
import 'package:madrasah_app/views/screens/see_all_announcements/see_all_announcements.dart';
import 'package:madrasah_app/views/screens/splash_screen/splash_screen.dart';

class RouteMangement {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.spleshScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case (RouteName.navBar):
        return MaterialPageRoute(builder: (context) => NavBar());
      case (RouteName.annouceMentDetails):
        return MaterialPageRoute(builder: (context) => SeeAllAnnouncement());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text('Sorry,Wrong route'),
                  ),
                ));
    }
  }
}
