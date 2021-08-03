import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:madrasah_app/views/screens/tabs/feeds/feeds.dart';
import 'package:madrasah_app/views/screens/tabs/tabs.dart';

class NavBarItem {
  final IconData icon;
  final String title;
  final Widget screen;

  NavBarItem({required this.icon, required this.title, required this.screen});
  static List<NavBarItem> navBarList = [
    NavBarItem(icon: Icons.home, title: 'Home', screen: HomePage()),
    NavBarItem(icon: Icons.feed, title: 'Feeds', screen: FeedPage()),
    NavBarItem(
        icon: Icons.notifications,
        title: 'Notifications',
        screen: NotificationTab()),
    NavBarItem(
        icon: Icons.person, title: 'Account', screen: AuthSensitiveScreen())
  ];
}
