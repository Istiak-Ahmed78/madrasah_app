import 'package:flutter/material.dart';
import 'package:madrasah_app/views/route_management/route_name.dart';
import 'package:madrasah_app/views/screens/tabs/home_tab/components/components.dart';
import 'package:madrasah_app/views/styles/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CResources.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeHeading(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Latest announcements',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: Fonts.monserrat),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: CResources.lightGrey,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)))),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteName.allAnnouncementScreen);
                            },
                            child: Text(
                              'See all',
                              style: TextStyle(
                                  color: CResources.blue, fontSize: 16),
                            ))
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                ),
                const NoticeListWidget(),
                SizedBox(
                  height: Dimensions.mediuim,
                ),
                HotItemSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
