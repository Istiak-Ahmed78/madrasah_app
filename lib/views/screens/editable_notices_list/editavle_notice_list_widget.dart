import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:madrasah_app/di_contailer.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/utils/fires_storage_repos.dart';
import 'package:madrasah_app/utils/firestore_repos/firestore_repos.dart';
import 'package:madrasah_app/utils/methods.dart';
import 'package:madrasah_app/views/route_management/route_name.dart';

class EditableNoticeList extends StatelessWidget {
  const EditableNoticeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.pushNamed(context, RouteName.addNewNoticeScreen);
        },
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: services<FirestoreRepos>().getNoticesStream(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              var _data = Methods.decodeNoticeModel(snapshot.data);
              if (_data.isNotEmpty) {
                return NoticeList(noticeList: _data);
              } else {
                return Center(child: Text('This list is emty'));
              }
            } else
              return Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}

class NoticeList extends StatelessWidget {
  final List<NoticeModel> noticeList;
  const NoticeList({Key? key, required this.noticeList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(noticeList[index].title),
          subtitle: noticeList[index].describtion != null
              ? Text(
                  noticeList[index].describtion!,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          trailing: SizedBox(
            width: 96,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteName.addNewNoticeScreen);
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                  onPressed: () {
                    Methods.showLoadingIndicator(
                        context: context,
                        workTodo: deleteANotice(noticeList[index].noticeId,
                            noticeList[index].attachmentLink));
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, RouteName.noticeDetailsScreen,
                arguments: noticeList[index]);
          },
        ),
        itemCount: noticeList.length,
        shrinkWrap: true,
      ),
    );
  }

  Future<void> deleteANotice(String noticeId, String? fileUrl) async {
    await services<FirestoreRepos>().deleteANotice(noticeId);
    if (fileUrl != null) {
      await services<StorageRepo>().daleteFile(fileUrl);
    }
  }
}
