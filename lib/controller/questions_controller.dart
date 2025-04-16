import 'dart:developer';
import 'package:get/get.dart';
import '../utils/api.dart';

class QuestionsController extends GetxController {
  int currentPage = 1;
  final int limit = 30;
  bool hasMore = true;
  bool isPaginating = false;

  List questions = [];
  bool loadingQuestions = true;
  bool isOpen = false;

  @override
  void onInit() {
    getQuestions();
    super.onInit();
  }

  void checkOpened(bool value) {
    isOpen = value;
    update();
  }

  void getQuestions({bool isFirstLoad = false}) {
    if (isPaginating || !hasMore) return;

    if (isFirstLoad) {
      currentPage = 1;
      questions.clear();
      loadingQuestions = true;
    } else {
      isPaginating = true;
    }

    update();

    API().get(
      url: '/questions?limit=$limit&page=$currentPage',
      onResponse: (response) {
        if (isFirstLoad) loadingQuestions = false;
        isPaginating = false;

        if (response.statusCode == 200 && response.data['success']) {
          List newQuestions = response.data['data'];
          if (newQuestions.isEmpty || newQuestions.length < limit) {
            hasMore = false;
          } else {
            currentPage++;
          }
          questions.addAll(newQuestions);
        }

        log('Fetched ${questions.length} questions');
        update();
      },
    );
  }
}
