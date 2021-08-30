import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madrasah_app/di_contailer.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/utils/firestore_repos/firestore_repos.dart';
import 'package:madrasah_app/utils/methods.dart';
import 'package:madrasah_app/views/route_management/route_name.dart';
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
          stream: services<FirestoreRepos>().getNoticesStream(),
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
                  // physics: const NeverScrollableScrollPhysics(),
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
        Navigator.pushNamed(context, RouteName.noticeDetailsScreen,
            arguments: noticeModel);
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
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isNew(String noticeId) {
    DateTime id = DateTime.parse(noticeId);
    return id.difference(DateTime.now()) < Duration(days: 1);
  }
}
