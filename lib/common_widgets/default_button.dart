import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/colors.dart';

class DefaultButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;
  final Color? primaryColor;
  final Color? textColor;
  const DefaultButton(
      {Key? key,
      this.onTap,
      required this.buttonText,
      this.primaryColor = CResources.black,
      this.textColor = CResources.white})
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
            style: TextStyle(color: CResources.white),
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

class Button extends ElevatedButton {
  final VoidCallback? onpressed;
  final Widget child;
  final double? height;
  final double? weight;
  Button(
      {required this.onpressed,
      required this.child,
      this.height = 50.0,
      this.weight = 90.0})
      : super(
          onPressed: onpressed,
          child: SizedBox(
            height: height,
          ),
        );
}
