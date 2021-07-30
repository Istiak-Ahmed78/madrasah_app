import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/styles.dart';

import '../../../../constants.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(style: BorderStyle.solid, width: 2)),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: noticeList.length,
        itemBuilder: (context, index) => Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10),
          constraints: BoxConstraints(maxHeight: 40, minHeight: 20),
          child: ListItem(
            title: noticeList[index],
            // isNew: true,
          ),
        ),
      ),
    );
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
