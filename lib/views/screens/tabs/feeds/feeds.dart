import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/styles.dart';
import '../../../../constants.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => FeedItem(
              feedText: Strings.dummyDescribtion,
              imageAdress: Images.nayagraWaterFall,
            ),
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}

class FeedItem extends StatelessWidget {
  final String feedText, imageAdress;
  const FeedItem({Key? key, required this.feedText, required this.imageAdress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: double.infinity,
        height: 400,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(Images.girlProfilePicture),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Isitak Ahmed',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('5 minute ago')
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageAdress), fit: BoxFit.cover)),
            ),
            Container(
              child: Text(
                'A beautiful visit in Nayagra fall',
                style: TextStyle(
                  fontFamily: Fonts.openSans,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 10, top: 10),
            ),
            Container(
              height: 60,
              width: double.infinity,
              child: Text(
                feedText,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: Fonts.monserrat, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
    );
  }
}
