import 'package:smart_app/MyHomePage.dart';
import 'package:smart_app/consts/colors.dart';
import 'package:smart_app/consts/consts.dart';
import 'package:smart_app/main.dart';
import 'package:smart_app/views/auth_screen/login_screen.dart';
import 'package:smart_app/views/home_screen/home.dart';
import 'package:smart_app/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //creating a method to change screen

  changeScreen() {
    Future.delayed(const Duration(seconds: 10), () {
      //using getX
      // Get.to(() => const LoginScreen());

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const Home());
          // Get.to(() => MyHomePage());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              // alignment: Alignment.topLeft,
              // child: Image.asset(icSplashBg, width: 300)
              alignment: Alignment.center,
              child: Image.asset(icAppLogo, width: 300)),
          60.heightBox,
          // applogoWidget(),
          // 10.heightBox,
          // appname.text.fontFamily(bold).size(22).white.make(),
          // appversion.text.white.make(),
          // const Spacer(),
          // credits.text.white.fontFamily(semibold).make(),
          // 30.heightBox,
        ],
      )),
    );
  }
}
