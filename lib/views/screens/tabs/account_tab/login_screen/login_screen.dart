import 'package:flutter/material.dart';
import 'package:madrasah_app/state_management/auth_state.dart';
import 'package:madrasah_app/utils/form_validation.dart';
import 'package:madrasah_app/utils/methods.dart';
import 'package:madrasah_app/views/shared_widgets/input_field.dart';
import 'package:madrasah_app/views/shared_widgets/shared_widgets.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import 'package:madrasah_app/views/styles/styles.dart';
import 'package:provider/provider.dart';
import '../../../../../constants.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final logInKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthState>(context);
    return Scaffold(
      backgroundColor: CResources.white,
      body: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: kTextTabBarHeight),
        width: double.infinity,
        height: _size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: _size.height * 0.3,
                width: _size.width * 0.6,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(Images.reading))),
              ),
              SizedBox(
                height: _size.height * 0.1,
              ),
              Form(
                  key: logInKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InputField(
                          textEditingController: emailController,
                          hintText: 'Your email Address',
                          validator: FormValidation.validateEmail,
                          textInputType: TextInputType.emailAddress,
                          icon: Icons.phone),
                      SizedBox(
                        height: 20,
                      ),
                      InputField(
                          textEditingController: passwordController,
                          hintText: 'Your password',
                          validator: FormValidation.validatePassword,
                          isPass: true,
                          icon: Icons.lock),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              authProvider.firebaseErrorMessgase == ''
                  ? Container()
                  : Text(
                      authProvider.firebaseErrorMessgase,
                      style: TextStyle(color: CResources.red),
                    ),
              SizedBox(
                height: _size.height * 0.1,
              ),
              DefaultButton(
                primaryColor: CResources.black,
                onTap: Provider.of<AuthState>(context).isLoading
                    ? null
                    : () {
                        if (logInKey.currentState!.validate()) {
                          Methods.showLoadingIndicator(
                              context: context, workTodo: logIn(context));
                        }
                      },
                buttonText: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logIn(context) async {
    await Provider.of<AuthState>(context, listen: false)
        .logInwithEmailAndPassword(
            emailController.text, passwordController.text);
  }
}
