import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import 'package:madrasah_app/views/styles/dimentions.dart';
import 'package:madrasah_app/views/styles/fonts.dart';
import '../../../constants.dart';

class SomeThingWentWrongScreen extends StatelessWidget {
  const SomeThingWentWrongScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CResources.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: CResources.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              margin: EdgeInsets.only(bottom: Dimensions.mediuim),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Images.somthingWentWrong))),
            ),
            Text(
              'Sorry, somthing went wrong',
              style: TextStyle(
                  color: CResources.blueGrey,
                  fontFamily: Fonts.monserrat,
                  fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
