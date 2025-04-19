import 'package:baiti/views/widgets/snack.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultationController extends GetxController {
  final mobileNumberController = TextEditingController();
  final topicController = TextEditingController();
  final descriptionController = TextEditingController();

  void submitConsultation() {
    if (mobileNumberController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إدخال رقم للتواصل');
      return;
    }
    if (topicController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إدخال الموضوع');
      return;
    }
    if (descriptionController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إدخال وصف الاستشارة');
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
  }
}
