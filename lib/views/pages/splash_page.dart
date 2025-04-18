import 'package:baiti/services/notifications_service.dart';

import '../../core/global.dart';
import '../../routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with NotificationsService {
  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();
    manageNotificationAction();
    Future.delayed(2.5.seconds, () {
      Get.offNamed(Global.token == "" ? Routes.loginPage : Routes.homePage);
    });
  }

  @override
  Widget build(BuildContext context) {
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
