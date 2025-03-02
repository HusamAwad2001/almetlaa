import 'dart:developer';
import 'package:get/get.dart';
import '../utils/api.dart';

class QuestionsController extends GetxController {

  @override
  void onInit() {
    getQuestions();
    super.onInit();
  }

  bool isOpen = false;
  void checkOpened(bool value) {
    isOpen = value;
    update();
  }

  List questions = [];
  bool loadingQuestions = true;

  getQuestions() {
    API().get(
      url: '/questions?limit=1000',
      onResponse: (response) {
        log(response.data.toString());
        loadingQuestions = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            questions = response.data['data'];
          }
        }
        update();
      },
    );
  }
}
