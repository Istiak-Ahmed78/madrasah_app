import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/styles.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final IconData? icon;
  final bool isPass;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String? Function(String?) validator;
  final int? maxLength;
  final int? maxLines;
  InputField({
    Key? key,
    required this.hintText,
    required this.validator,
    required this.textEditingController,
    this.icon,
    this.maxLength,
    this.maxLines,
    this.isPass = false,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isShow = false;
  var border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10)));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 60,
      child: TextFormField(
        validator: widget.validator,
        controller: widget.textEditingController,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        cursorColor: CResources.black,
        obscureText: widget.isPass ? !isShow : false,
        keyboardType: widget.textInputType,
        style: TextStyle(color: CResources.black, fontFamily: Fonts.openSans),
        decoration: InputDecoration(
            hintText: widget.hintText,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: border,
            focusedErrorBorder: border,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintStyle: TextStyle(
              color: CResources.black,
            ),
            prefixIcon: widget.icon != null
                ? Icon(
                    widget.icon,
                    size: 20,
                    color: CResources.greyShade,
                  )
                : null,
            suffixIcon: widget.isPass
                ? InkWell(
                    onTap: () {
                      setState(() => isShow = !isShow);
                    },
                    child: Icon(
                      isShow ? Icons.visibility_off : Icons.visibility,
                      color: CResources.grey,
                    ))
                : null,
            fillColor: CResources.black.withOpacity(0.1),
            filled: true),
      ),
    );
  }
}
