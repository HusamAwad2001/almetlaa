import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../core/storage.dart';
import '../routes/routes.dart';
import '../utils/api.dart';
import '../core/global.dart';
import '../views/widgets/loading_dialog.dart';
import '../views/widgets/snack.dart';

class LoginController extends GetxController{

  TextEditingController phoneTEC = TextEditingController();
  TextEditingController passTEC = TextEditingController();

  validate(){
    if(phoneTEC.text.isEmpty){
      Snack().show(type: false, message: "الرجاء إدخال رقم الهاتف");
    }else if(passTEC.text.isEmpty){
      Snack().show(type: false, message: "الرجاء إدخال كلمة المرور");
    }else{
      LoadingDialog().dialog();
      API().post(url: '/auth/login', body: {
        "phoneNumber":phoneTEC.text,
        "password":passTEC.text
      }
          , onResponse: (response){
            Get.back();
            if(response.data['success']){
              Global.token = response.data['token'];
              Global.user = response.data['data'];
              Storage.instance.write("token", response.data['token']);
              Storage.instance.write("user", response.data['data']);
              Get.offAllNamed(Routes.homePage);
            }else{
              Snack().show(type: false, message:  response.data['error']);
            }
          });
    }
  }
}