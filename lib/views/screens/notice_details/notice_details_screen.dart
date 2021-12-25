import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/utils/methods.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import 'package:madrasah_app/views/styles/dimentions.dart';
import 'package:madrasah_app/views/styles/styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoticeDetails extends StatelessWidget {
  final NoticeModel noticeModel;
  const NoticeDetails({Key? key, required this.noticeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noticeModel.title,
                  style: TextStyle(
                      fontSize: Dimensions.mediuim,
                      color: CResources.blueGrey,
                      fontFamily: Fonts.openSans),
                ),
                SizedBox(
                  height: Dimensions.mediuim,
                ),
                Text(
                  timeago.format(DateTime.parse(noticeModel.noticeId)),
                  style: TextStyle(color: CResources.orangeAccent),
                ),
                SizedBox(
                  height: Dimensions.learge,
                ),
                noticeModel.describtion != null
                    ? Text(
                        noticeModel.describtion!,
                        style: TextStyle(fontFamily: Fonts.monserrat),
                      )
                    : SizedBox.shrink(),
                noticeModel.attachmentLink != null
                    ? Center(
                        child: MaterialButton(
                          color: CResources.blueGrey.withOpacity(0.02),
                          onPressed: () {
                            Methods.launchUrl(noticeModel.attachmentLink!);
                          },
                          child: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                Icon(Icons.attach_file),
                                Text(
                                  'Attachment',
                                  style: TextStyle(
                                      color: CResources.white.withOpacity(0.7)),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Center(
                            child: Text(
                          'End of this list',
                          style: TextStyle(color: CResources.grey),
                        )),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
