import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import 'package:madrasah_app/views/styles/styles.dart';

import '../../../constants.dart';

class SeeAllAnnouncement extends StatelessWidget {
  const SeeAllAnnouncement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CResources.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
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
        child: ListView.builder(
          itemBuilder: (context, index) => AnnouncementItem(
            tittle: 'Story of Great prophet Muhammad(SM)',
            contentText: Strings.mohammadSMStory,
          ),
          itemCount: 5,
          shrinkWrap: true,
        ),
      ),
    );
  }
}

class AnnouncementItem extends StatelessWidget {
  final String tittle;
  final String contentText;

  const AnnouncementItem(
      {Key? key, required this.tittle, required this.contentText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                tittle,
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
                  contentText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(fontFamily: Fonts.monserrat),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
