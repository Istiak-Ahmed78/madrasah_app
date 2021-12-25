import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/utils/fires_storage_repos.dart';
import 'package:madrasah_app/utils/firestore_repos/firestore_repos.dart';
import 'package:madrasah_app/utils/methods.dart';
import 'package:madrasah_app/views/screens/add_notice_screem/add_notice.dart';
import 'package:madrasah_app/views/screens/emty_list_screen/emty_list_screen.dart';
import 'package:madrasah_app/views/screens/notice_details/notice_details_screen.dart';
import 'package:madrasah_app/views/screens/something_went_wrong/something_went_wrong.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import 'package:madrasah_app/views/styles/fonts.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class EditableNoticeList extends StatelessWidget {
  const EditableNoticeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddNoticeScreen());
        },
      ),
      appBar: AppBar(
        title: Text(
          'Notices',
          style: TextStyle(
            color: CResources.teal,
            fontFamily: Fonts.openSans,
          ),
        ),
        centerTitle: true,
        backgroundColor: CResources.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: CResources.black.withOpacity(0.7),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: FirestoreRepos().getNoticesStream(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Text(
                'Please wait. Loading data',
                style: TextStyle(
                    color: CResources.blueAccent, fontFamily: Fonts.monserrat),
              ));
            } else if (snapshot.hasData) {
              var _data = Methods.decodeNoticeModel(snapshot.data);
              if (_data.isNotEmpty) {
                return NoticeList(noticeList: _data);
              } else {
                return EmtyListScreen();
              }
            } else
              return SomeThingWentWrongScreen();
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
                      // Navigator.pushNamed(context, RouteName.addNewNoticeScreen,
                      //     arguments: noticeList[index]);
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                  onPressed: () async {
                    Methods.deleteConfirmationPopUp(
                        noticeTitle: noticeList[index].title.substring(0, 12),
                        context: context,
                        onDelelte: () async {
                          await Methods.showLoadingIndicator(
                              context: _scaffoldKey.currentState!.context,
                              workTodo: deleteANotice(
                                  noticeList[index].noticeId,
                                  noticeList[index].attachmentLink));
                        });
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
            // Get.to(()=> NoticeDetails(noticeModel: noticeModel));
          },
        ),
        itemCount: noticeList.length,
        shrinkWrap: true,
      ),
    );
  }

  Future<void> deleteANotice(String noticeId, String? fileUrl) async {
    if (fileUrl != null) {
      await StorageRepo().daleteFile(fileUrl);
    }
    await FirestoreRepos().deleteANotice(noticeId)
        // .timeout(Duration(seconds: 3))
        .then((_) {
      Methods.showToast(toastMessage: 'Notice deleted');
    }).catchError((_error) {
      Methods.showToast(toastMessage: '$_error');
    });
  }
}
