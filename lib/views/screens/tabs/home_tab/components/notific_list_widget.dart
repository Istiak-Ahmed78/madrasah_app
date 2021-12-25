import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/services/cloud_services.dart';
import 'package:madrasah_app/utils/methods.dart';
import 'package:madrasah_app/views/screens/notice_details/notice_details_screen.dart';
import 'package:madrasah_app/views/styles/styles.dart';
import '../../../../../constants.dart';

class NoticeListWidget extends StatelessWidget {
  const NoticeListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 150,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(style: BorderStyle.solid, width: 2)),
        child: StreamBuilder(
          stream: FirestoreRepos().getNoticesStream(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Text(
                'Loading',
                style: TextStyle(fontFamily: Fonts.openSans),
              ));
            } else if (snapshot.hasData) {
              if (snapshot.data == null) {
                return Text('Null result');
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text(
                  'No item to show',
                  style: TextStyle(
                      color: CResources.blueAccent,
                      fontFamily: Fonts.monserrat),
                ));
              } else if (snapshot.data!.docs.isNotEmpty) {
                var dataList = Methods.decodeNoticeModel(snapshot.data!);
                return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) => Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    constraints: BoxConstraints(maxHeight: 40, minHeight: 20),
                    child: ListItem(
                      noticeModel: dataList[index],
                    ),
                  ),
                );
              } else {
                return Text(FirebaseErrorMessages.defaultErrorMessage);
              }
            } else {
              return Text(FirebaseErrorMessages.defaultErrorMessage);
            }
          },
        ));
  }
}

class ListItem extends StatelessWidget {
  final NoticeModel noticeModel;
  const ListItem({
    Key? key,
    required this.noticeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NoticeDetails(noticeModel: noticeModel));
      },
      child: Container(
        color: CResources.grey.withOpacity(0.2),
        height: 35,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: Dimensions.small),
              child: CircleAvatar(
                radius: 7,
                backgroundColor: isNew(noticeModel.noticeId)
                    ? CResources.orangeAccent
                    : CResources.trasparent,
              ),
            ),
            Expanded(
              child: Text(
                noticeModel.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: Fonts.openSans),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isNew(String noticeId) {
    DateTime id = DateTime.parse(noticeId);
    return DateTime.now().difference(id) < Duration(hours: 5);
  }
}
