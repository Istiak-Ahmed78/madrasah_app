import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import 'package:madrasah_app/views/styles/dimentions.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.mediuim),
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Card(
            child: ListTile(
              title: Text(
                'Someone loved your article',
                style: TextStyle(color: CResources.black.withOpacity(0.6)),
              ),
              tileColor: CResources.blueGrey.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          ),
        ),
        itemCount: 5,
        shrinkWrap: true,
      ),
    );
  }
}
