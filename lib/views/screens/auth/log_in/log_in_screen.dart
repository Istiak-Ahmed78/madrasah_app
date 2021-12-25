import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madrasah_app/common_widgets/common_loading.dart';
import 'package:madrasah_app/globals/controllers/auth_controller.dart';
import 'package:madrasah_app/utils/form_validation.dart';
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
    return GetX<AuthController>(builder: (authController) {
      return CommonLoadingOverlay(
        loading: authController.isLoading.value,
        child: Scaffold(
            backgroundColor: CResources.white,
            body: Container(
              width: double.infinity,
              height: Get.height,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: Get.height * 0.3,
                        width: Get.width * 0.6,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Images.reading))),
                      ),
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                      Form(
                          key: logInKey,
                          child: Column(
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
                        height: Get.height * 0.05,
                      ),
                      DefaultButton(
                        primaryColor: CResources.black,
                        onTap: authController.isLoading.value
                            ? null
                            : () async {
                                if (logInKey.currentState!.validate()) {
                                  await AuthController.to.signIn(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                        buttonText: 'Log In',
                      ),
                    ],
                  ),
                ),
              ),
            )),
      );
    });
  }
}
