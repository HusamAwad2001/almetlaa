import 'package:baiti/views/widgets/snack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultationController extends GetxController {
  final mobileNumberController = TextEditingController();
  final topicController = TextEditingController();

  void submitConsultation() {
    if (topicController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إدخال الموضوع');
      return;
    }
    if (mobileNumberController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إدخال رقم التواصل');
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
  }
}
