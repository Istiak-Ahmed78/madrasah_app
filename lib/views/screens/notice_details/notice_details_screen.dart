import 'package:flutter/material.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/utils/methods.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import 'package:madrasah_app/views/styles/dimentions.dart';

class NoticeDetails extends StatelessWidget {
  final NoticeModel noticeModel;
  const NoticeDetails({Key? key, required this.noticeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notice details'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: CResources.blueAccent,
      ),
      body: Container(
        height: size(context).height,
        width: size(context).width,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                noticeModel.title,
                style: TextStyle(
                    fontSize: Dimensions.mediuim, color: CResources.blueGrey),
              ),
              SizedBox(
                height: Dimensions.mediuim,
              ),
              noticeModel.describtion != null
                  ? Text(noticeModel.describtion!)
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
                  : Center(
                      child: Text('No more details available'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
