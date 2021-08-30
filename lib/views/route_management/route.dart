import 'package:flutter/material.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/views/route_management/route_name.dart';
import 'package:madrasah_app/views/screens/add_notice_screem/add_notice.dart';
import 'package:madrasah_app/views/screens/editable_notices_list/editavle_notice_list_widget.dart';
import 'package:madrasah_app/views/screens/nav_bar/nav_bar.dart';
import 'package:madrasah_app/views/screens/notice_details/notice_details_screen.dart';
import 'package:madrasah_app/views/screens/see_all_announcements/see_all_announcements.dart';
import 'package:madrasah_app/views/screens/something_went_wrong/something_went_wrong.dart';
import 'package:madrasah_app/views/screens/splash_screen/splash_screen.dart';

class RouteMangement {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.spleshScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case (RouteName.navBar):
        return MaterialPageRoute(builder: (context) => NavBar());
      case (RouteName.allAnnouncementScreen):
        return MaterialPageRoute(builder: (context) => SeeAllAnnouncement());

      case (RouteName.editableNoticeList):
        return MaterialPageRoute(builder: (context) => EditableNoticeList());
      case (RouteName.addNewNoticeScreen):
        NoticeModel? noticeModel = settings.arguments as NoticeModel?;
        return MaterialPageRoute(
            builder: (context) => AddNoticeScreen(
                  noticeModel: noticeModel,
                ));
      case (RouteName.noticeDetailsScreen):
        NoticeModel noticeModel = settings.arguments as NoticeModel;
        return MaterialPageRoute(
            builder: (context) => NoticeDetails(
                  noticeModel: noticeModel,
                ));
      default:
        return MaterialPageRoute(
            builder: (context) => SomeThingWentWrongScreen());
    }
  }
}
