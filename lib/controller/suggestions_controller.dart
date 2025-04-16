import '../../views/widgets/loading_dialog.dart';
import '../../views/widgets/snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/global.dart';
import '../routes/routes.dart';
import '../utils/api.dart';

class SuggestionsController extends GetxController {
  final topicController = TextEditingController();
  final suggestionController = TextEditingController();

  createSuggestion() {
    LoadingDialog().dialog();
    API().post(
      url: '/suggestions',
      body: {
        "suggestion": suggestionController.text,
        "topic": topicController.text,
      },
      onResponse: (response) {
        Get.back();
        update();
        if (response.success) {
          Snack().show(
            type: true,
            message: 'تم إرسال الإقتراح بنجاح',
          );
          suggestionController.clear();
          topicController.clear();
          update();
        }
      },
      onError: (errorModel) {
        Get.back();
        Snack().show(
          message: errorModel.message ?? 'حدث خطأ ما',
          type: false,
        );
      },
    );
  }

  validate() {
    if (Global.token.isEmpty || Global.user.isEmpty) {
      Snack().show(type: false, message: 'يرجى تسجيل الدخول');
      Get.offAllNamed(Routes.loginPage);
      return;
    }
    if (topicController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إضافة الموضوع');
      return;
    }
    if (suggestionController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إضافة الإقتراح');
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    createSuggestion();
  }
}
