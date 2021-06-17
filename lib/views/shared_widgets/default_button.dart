import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/colors.dart';

class DefaultButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Color? primaryColor;
  final Color? textColor;
  const DefaultButton(
      {Key? key,
      required this.onTap,
      required this.buttonText,
      this.primaryColor = kBlack,
      this.textColor = kWhite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(
            buttonText,
            style: TextStyle(color: kWhite),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor!),
          ),
        ));
  }
}
