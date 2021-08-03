import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madrasah_app/di_contailer.dart';
import 'package:madrasah_app/utils/firestore_repos/firestore_repos.dart';
import 'package:madrasah_app/utils/methods.dart';
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
          stream: services<FirestoreRepos>().getNotices(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              if (snapshot.data == null) {
                return Text('Null result');
              } else if (snapshot.data!.docs.isEmpty) {
                return Text('No item to show');
              } else if (snapshot.data!.docs.isNotEmpty) {
                var dataList = Methods.decodeNoticeModel(snapshot.data!);
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dataList.length,
                  itemBuilder: (context, index) => Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    constraints: BoxConstraints(maxHeight: 40, minHeight: 20),
                    child: ListItem(
                      title: dataList[index].title,
                      // isNew: true,
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
  final String title;
  final bool isNew;
  const ListItem({Key? key, required this.title, this.isNew = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: Dimensions.small),
            child: CircleAvatar(
              radius: 7,
              backgroundColor:
                  isNew ? CResources.orangeAccent : CResources.trasparent,
            ),
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
