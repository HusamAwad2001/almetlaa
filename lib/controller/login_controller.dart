import 'package:baiti/core/global.dart';
import 'package:baiti/core/storage.dart';
import 'package:baiti/routes/routes.dart';
import 'package:baiti/views/pages/verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../utils/api.dart';
import '../views/widgets/loading_dialog.dart';
import '../views/widgets/snack.dart';

class LoginController extends GetxController {
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController otpController = TextEditingController();

  validate() {
    if (phoneTEC.text.isEmpty) {
      Snack().show(type: false, message: "الرجاء إدخال رقم الهاتف");
      return;
    }
    if (phoneTEC.text.length < 10) {
      Snack().show(type: false, message: "يرجى إدخال رقم هاتف صحيح");
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    LoadingDialog().dialog();
    API().post(
      url: '/auth/login',
      body: {"phoneNumber": phoneTEC.text},
      onResponse: (response) {
        Get.back();
        if (response.data['success']) {
          Get.to(() => VerificationScreen());
        } else {
          Snack().show(type: false, message: response.data['error']);
        }
      },
      onError: (error) {
        Get.back();
        Snack().show(type: false, message: error.message ?? 'حدث خطأ ما');
      },
    );
  }

  verifyOtp() {
    if (otpController.text.isEmpty) {
      Snack().show(type: false, message: "الرجاء إدخال رمز التحقق");
      return;
    }
    if (otpController.text.length < 6) {
      Snack().show(type: false, message: "رمز التحقق غير صحيح");
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    LoadingDialog().dialog();
    API().post(
      url: '/auth/confirmCode',
      body: {
        // "phoneNumber": "965${phoneTEC.text}",
        "phoneNumber": phoneTEC.text,
        "code": otpController.text,
      },
      onResponse: (response) {
        Get.back();
        if (response.data['success']) {
          Global.token = response.data['token'];
          Global.user = response.data['data'];
          Storage.instance.write("token", response.data['token']);
          Storage.instance.write("user", response.data['data']);
          Get.offAllNamed(Routes.homePage);
        } else {
          Snack().show(type: false, message: response.data['data']);
        }
      },
      onError: (error) {
        Get.back();
        Snack().show(type: false, message: error.message ?? 'حدث خطأ ما');
      },
    );
  }
}
