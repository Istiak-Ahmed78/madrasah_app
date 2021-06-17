import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/styles.dart';

import '../../../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: _size.height * 0.3,
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Image.asset(
                      madrasahLogoAdress,
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
                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 30),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Announcements',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: kLightGrey,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          onPressed: () {},
                          child: Text(
                            'See all',
                            style: TextStyle(color: kBlue, fontSize: 16),
                          ))
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                ),
              ),
              Container(
                width: double.infinity,
                height: 150,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(style: BorderStyle.solid, width: 2)),
                child: ListView.builder(
                  itemCount: noticeList.length,
                  itemBuilder: (context, index) => Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    constraints: BoxConstraints(maxHeight: 40, minHeight: 20),
                    child: Text(
                      noticeList[index],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
