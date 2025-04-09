import 'dart:io';

import 'package:almetlaa/routes/routes.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/internet_controller.dart';
import '../../core/global.dart';
import '../widgets/spinner_widget.dart';

class InternetPage extends StatelessWidget {
  const InternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Image.asset(
          'assets/images/baiti_logo.png',
          height: 30,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<InternetController>(
            init: InternetController(),
            builder: (controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/baiti_logo.png',
                    // color: Constants.primaryColor,
                    width: 200,
                  ),
                  20.ph,
                  const Text(
                    "قد لا يتوفر الإنترنت",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  controller.loading
                      ? const IconButton(
                          onPressed: null,
                          icon: SpinnerWidget(
                            color: Constants.primaryColor,
                          ),
                          color: Constants.primaryColor,
                          iconSize: 50,
                        )
                      : IconButton(
                          onPressed: () async {
                            controller.loading = true;
                            controller.update();
                            await Future.delayed(1.seconds);
                            try {
                              final result =
                                  await InternetAddress.lookup('google.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
                                if (Global.token == "") {
                                  Get.offAllNamed(Routes.loginPage);
                                } else {
                                  Get.back();
                                }
                              }
                            } on SocketException catch (_) {
                              controller.loading = false;
                              controller.update();
                            }
                          },
                          icon: const Icon(Icons.refresh),
                          color: Constants.primaryColor,
                          iconSize: 50,
                        ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
