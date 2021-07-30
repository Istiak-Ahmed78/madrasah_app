import 'package:flutter/material.dart';
import 'package:madrasah_app/views/screens/nav_bar/nav_bar_items.dart';
import 'package:madrasah_app/views/styles/colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [for (final _item in NavBarItem.navBarList) _item.screen],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: CResources.blueGrey,
        unselectedItemColor: CResources.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          for (final _item in NavBarItem.navBarList)
            BottomNavigationBarItem(
              icon: Icon(_item.icon),
              label: _item.title,
            )
        ],
      ),
    );
  }
}
