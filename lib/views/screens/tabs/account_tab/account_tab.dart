import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:madrasah_app/views/constants.dart';
import 'package:madrasah_app/views/screens/sign_up_screen/sign_up_screen.dart';
import 'package:madrasah_app/views/shared_widgets/input_field.dart';
import 'package:madrasah_app/views/shared_widgets/shared_widgets.dart';
import 'package:madrasah_app/views/styles/colors.dart';

class AccountTab extends StatelessWidget {
  AccountTab({Key? key}) : super(key: key);
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: size.height - kToolbarHeight,
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              Text('Log in',
                  style: TextStyle(fontSize: 30, fontFamily: kOpenSans)),
              SizedBox(
                height: size.height * 0.1,
              ),
              InputField(
                  textEditingController: phoneController,
                  hintText: 'Your phone number',
                  textInputType: TextInputType.number,
                  icon: Icons.phone),
              SizedBox(
                height: 20,
              ),
              InputField(
                  textEditingController: passwordController,
                  hintText: 'Your password',
                  isPass: true,
                  icon: Icons.lock),
              Spacer(),
              DefaultButton(
                primaryColor: kBlack,
                onTap: () {},
                buttonText: 'Log In',
              ),
              Spacer(),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: kBlack)),
                  TextSpan(
                      text: 'Create account',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                      style:
                          TextStyle(color: kRed, fontWeight: FontWeight.bold))
                ]),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
