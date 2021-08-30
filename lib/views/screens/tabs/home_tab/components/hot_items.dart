import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import '../../../../../constants.dart';

class HotItemSection extends StatelessWidget {
  const HotItemSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Item(
          title: 'Books',
          imageAddress: Images.bookImage,
          onPressed: () {},
        ),
        Item(
          title: 'Classes',
          imageAddress: Images.classroomIcon,
          onPressed: () {},
        ),
      ],
    ));
  }
}

class Item extends StatelessWidget {
  final String title, imageAddress;
  final Function() onPressed;
  const Item(
      {Key? key,
      required this.imageAddress,
      required this.onPressed,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: InkWell(
        onTap: onPressed,
        child: Container(
            height: 130,
            width: 100,
            child: Column(
              children: [
                Expanded(child: Image.asset(imageAddress)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    title,
                    style: TextStyle(color: CResources.blueGrey),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
