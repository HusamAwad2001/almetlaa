import 'package:almetlaa/core/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';
import '../utils/api.dart';
import '../core/global.dart';
import '../views/widgets/loading_dialog.dart';
import '../views/widgets/snack.dart';

class RegisterController extends GetxController {
  int select = -1;

  TextEditingController nameTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController pass1TEC = TextEditingController();
  TextEditingController pass2TEC = TextEditingController();

  validate() {
    if (nameTEC.text.isEmpty) {
      Snack().show(type: false, message: "الرجاء إدخال الإسم");
    } else if (phoneTEC.text.isEmpty) {
      Snack().show(type: false, message: "الرجاء إدخال رقم الهاتف");
    } else if (pass1TEC.text.isEmpty) {
      Snack().show(type: false, message: "الرجاء إدخال كلمة المرور");
    } else if (pass2TEC.text.isEmpty) {
      Snack().show(type: false, message: "الرجاء إدخال تأكيد كلمة المرور");
    } else {
      if (pass1TEC.text != pass2TEC.text) {
        Snack().show(type: false, message: "كلمة المرور غير متطابقة");
      } else {
        FocusManager.instance.primaryFocus?.unfocus();
        LoadingDialog().dialog();
        API().post(
          url: '/auth/register',
          body: {
            "name": nameTEC.text,
            "phoneNumber": phoneTEC.text,
            "password": pass1TEC.text
          },
          onResponse: (response) {
            Get.back();
            if (response.data['success']) {
              Global.token = response.data['token'];
              Global.user = response.data['data'];
              Storage.instance.write("token", response.data['token']);
              Storage.instance.write("user", response.data['data']);
              Get.offNamed(Routes.homePage);
            } else {
              Snack().show(type: false, message: response.data['error']);
              debugPrint(response.data['error']);
            }
          },
        );
      }
    }
  }
}
