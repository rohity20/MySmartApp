import 'package:smart_app/controllers/auth_controller.dart';
import 'package:smart_app/views/home_screen/home.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../consts/lists.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';
import '../../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(children: [
          (context.screenHeight * 0.1).heightBox,
          // applogoWidget(),
          meeshologoWidget(),
          10.heightBox,
          "Join the $appname".text.fontFamily(bold).white.size(18).make(),
          //  "Join the $appname".text.fontFamily(bold).white.size(18).make(),
          10.heightBox,
          Obx(() => Column(
                    children: [
                      customTextField(
                          hint: nameHint,
                          title: name,
                          controller: nameController,
                          isPass: false),
                      customTextField(
                          hint: emailHint,
                          title: email,
                          controller: emailController,
                          isPass: false),
                      customTextField(
                          hint: passwordHint,
                          title: password,
                          controller: passwordController,
                          isPass: true),
                      customTextField(
                          hint: passwordHint,
                          title: retypePassword,
                          controller: passwordRetypeController,
                          isPass: true),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {}, child: forgetPass.text.make())),
                      5.heightBox,
                      controller.isloading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.blue),
                            )
                          : ourButton(
                              color: Colors.blue[400],
                              title: signup,
                              textColor: whiteColor,
                              onPress: () async {
                                // if (isCheck != false) {}
                                controller.isloading(true);
                                try {
                                  await controller
                                      .signupMethod(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text)
                                      .then((value) {
                                    return controller
                                        .storeUserData(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text)
                                        .then((value) {
                                      VxToast.show(context, msg: loggedin);
                                      Get.offAll(() => const Home());
                                    });
                                  });
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                  controller.isloading(false);
                                }
                              },
                            ).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      //wrapping into gesture detector of velocity X
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: alreadyHaveAccount,
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey),
                            ),
                            TextSpan(
                              text: login,
                              style: TextStyle(
                                  fontFamily: bold, color: Colors.blue),
                            )
                          ],
                        ),
                      ).onTap(() {
                        Get.back();
                      })
                    ],
                  ))
              .box
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .width(context.screenWidth - 70)
              .make(),
        ]),
      ),
    ));
  }
}
