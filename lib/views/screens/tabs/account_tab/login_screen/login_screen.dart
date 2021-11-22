import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/globals/controllers/auth_controller.dart';
import 'package:madrasah_app/utils/form_validation.dart';
import 'package:madrasah_app/views/shared_widgets/input_field.dart';
import 'package:madrasah_app/views/shared_widgets/shared_widgets.dart';
import 'package:madrasah_app/views/styles/colors.dart';
import 'package:madrasah_app/views/styles/styles.dart';
import '../../../../../constants.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final logInKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CResources.white,
      body: GetBuilder<AuthController>(builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
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
                      image:
                          DecorationImage(image: AssetImage(Images.reading))),
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
                SizedBox(
                  height: _size.height * 0.1,
                ),
                DefaultButton(
                  primaryColor: CResources.black,
                  onTap: controller.isLoading
                      ? null
                      : () {
                          // if (logInKey.currentState!.validate()) {
                          //   Methods.showLoadingIndicator(
                          //       context: context, workTodo: logIn(context));
                          // }
                        },
                  buttonText: 'Log In',
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> logIn(AuthController authController) async {
    await authController.logInwithEmailAndPassword(
        emailController.text, passwordController.text);
  }
}
