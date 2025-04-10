import '../../core/global.dart';
import '../../routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  _splash() async {
    await Future.delayed(2.5.seconds);
    Get.offNamed(Global.token == "" ? Routes.loginPage : Routes.homePage);
  }

  @override
  Widget build(BuildContext context) {
    _splash();
    return Scaffold(
      body: Image.asset(
        'assets/images/splash.gif',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
