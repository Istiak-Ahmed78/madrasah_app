import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/styles.dart';

import '../../../constants.dart';

class EmtyListScreen extends StatelessWidget {
  const EmtyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            margin: EdgeInsets.only(bottom: Dimensions.mediuim),
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(Images.emtyListImage))),
          ),
          Text(
            'No item to show',
            style: TextStyle(
                color: CResources.blueGrey,
                fontFamily: Fonts.monserrat,
                fontSize: 16),
          )
        ],
      ),
    );
  }
}
