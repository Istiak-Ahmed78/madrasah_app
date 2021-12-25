import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:madrasah_app/models/notice_model.dart';

import 'package:url_launcher/url_launcher.dart';

class Methods {
  static List<NoticeModel> decodeNoticeModel(
      QuerySnapshot<Map<String, dynamic>>? querySnapshot) {
    List<NoticeModel> shoppingCartList = [];
    if (querySnapshot != null) {
      for (final item in (querySnapshot).docs) {
        shoppingCartList.add(NoticeModel.fromMap(item.data()));
      }
      return shoppingCartList;
    } else {
      return shoppingCartList;
    }
  }

  static launchUrl(String urlToLauch) async {
    if (await canLaunch(urlToLauch)) {
      launch(urlToLauch);
    } else {
      Get.snackbar('Error', 'Could not launch');
    }
  }
}
