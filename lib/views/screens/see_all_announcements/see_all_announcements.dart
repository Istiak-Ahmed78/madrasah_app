import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/utils/firestore_repos/firestore_repos.dart';
import 'package:madrasah_app/utils/methods.dart';
import 'package:madrasah_app/views/screens/emty_list_screen/emty_list_screen.dart';
import 'package:madrasah_app/views/screens/notice_details/notice_details_screen.dart';
import 'package:madrasah_app/views/screens/something_went_wrong/something_went_wrong.dart';
import 'package:madrasah_app/views/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class SeeAllAnnouncement extends StatelessWidget {
  const SeeAllAnnouncement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CResources.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: CResources.grey,
          ),
        ),
        title: Text(
          'Announcements',
          style: TextStyle(fontFamily: Fonts.openSans, color: CResources.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: CResources.white,
      body: Container(
          child: FutureBuilder(
        future: FirestoreRepos().getNoticesSnapshot(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            var _data = Methods.decodeNoticeModel(snapshot.data);
            if (_data.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) => AnnouncementItem(
                  noticeModel: _data[index],
                ),
                itemCount: _data.length,
                shrinkWrap: true,
              );
            } else {
              return EmtyListScreen();
            }
          } else if (snapshot.hasError) {
            return SomeThingWentWrongScreen();
          } else {
            return CircularProgressIndicator();
          }
        },
      )),
    );
  }
}

class AnnouncementItem extends StatelessWidget {
  final NoticeModel noticeModel;

  const AnnouncementItem({Key? key, required this.noticeModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          Get.to(() => NoticeDetails(noticeModel: noticeModel));
        },
        child: Card(
          color: CResources.lightGrey,
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(maxHeight: 120),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noticeModel.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: Fonts.openSans),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Text(
                    noticeModel.describtion ??
                        'This notice don\'t have describtion',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                        fontFamily: Fonts.monserrat, color: CResources.red),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                      timeago.format(DateTime.parse(noticeModel.noticeId))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
