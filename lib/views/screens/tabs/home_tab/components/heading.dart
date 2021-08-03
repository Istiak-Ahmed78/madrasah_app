import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/styles.dart';

import '../../../../../constants.dart';

class HomeHeading extends StatelessWidget {
  const HomeHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: _size.height * 0.3,
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Image.asset(
            Images.madrashaLogo,
            height: 100,
            width: 100,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              'Habibpur Fazil Madrash',
              textAlign: TextAlign.start,
              style: TextStyle(fontFamily: Fonts.openSans, fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
