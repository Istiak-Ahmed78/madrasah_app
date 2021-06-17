import 'package:flutter/material.dart';
import 'package:madrasah_app/views/constants.dart';
import 'package:madrasah_app/views/styles/styles.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: size(context).height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kTeal.withOpacity(0.1),
                          image: DecorationImage(
                              image: NetworkImage(dummyImageAdress),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Container(
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Istiak Ahmed',
                                style: TextStyle(
                                    fontFamily: kOpenSans,
                                    fontSize: 25,
                                    shadows: [
                                      Shadow(
                                          color: kBlack.withOpacity(0.3),
                                          offset: Offset(0, 2))
                                    ],
                                    fontWeight: FontWeight.bold),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Class: ',
                                        style: TextStyle(color: kBlack)),
                                    TextSpan(
                                        text: '6',
                                        style: TextStyle(
                                            color: kRed,
                                            fontFamily: kOpenSans,
                                            fontWeight: FontWeight.bold))
                                  ])),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Current Roll no.: ',
                                        style: TextStyle(color: kBlack)),
                                    TextSpan(
                                        text: '23',
                                        style: TextStyle(
                                            color: kRed,
                                            fontFamily: kOpenSans,
                                            fontWeight: FontWeight.bold))
                                  ]))
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size(context).height * 0.1,
                  ),
                  Row(
                    children: [
                      HighlightWidget(
                        title: 'Awards',
                        bottomNumer: '2',
                      ),
                      HighlightWidget(
                          title: 'Your published articls', bottomNumer: '03')
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Your attendence \n status:',
                        style: TextStyle(fontSize: 20),
                      ),
                      PieChart(
                        persent: 70,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Button(
                        buttonText: 'Edit your profile',
                        onTap: () {},
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Button(
                      buttonText: 'Log out',
                      onTap: () {},
                      backGroundColor: kRedAccent.withOpacity(0.7),
                      buttonTextColor: kWhite,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Color backGroundColor, buttonTextColor;
  const Button(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.backGroundColor = kLightGrey,
      this.buttonTextColor = kBlack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: backGroundColor,
          onPressed: onTap,
          child: Text(
            buttonText,
            style: TextStyle(
                fontFamily: kOpenSans,
                color: buttonTextColor,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}

class HighlightWidget extends StatelessWidget {
  final String title, bottomNumer;
  const HighlightWidget(
      {Key? key, required this.title, required this.bottomNumer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            bottomNumer,
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }
}

class PieChart extends StatefulWidget {
  final int persent;
  const PieChart({Key? key, required this.persent}) : super(key: key);

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  double persentFromIntToDouble(int persent) {
    if (persent <= 100)
      return persent / 100;
    else
      return 0.0;
  }

  Color activeColor(persent) {
    if (persent >= 80)
      return kBlue;
    else if (persent >= 60)
      return kGreen;
    else if (persent >= 40)
      return kYellow;
    else
      return kRed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: CircularPercentIndicator(
        radius: 120,
        percent: persentFromIntToDouble(widget.persent),
        progressColor: activeColor(widget.persent),
        animation: true,
        animationDuration: 1500,
        lineWidth: 13,
        center: Text('${widget.persent}%'),
      ),
    );
  }
}
