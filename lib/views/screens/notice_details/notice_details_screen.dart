import 'package:flutter/material.dart';
import 'package:madrasah_app/models/notice_model.dart';
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
        leading: Icon(Icons.arrow_back),
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
            ],
          ),
        ),
      ),
    );
  }
}
