import 'package:get/get.dart';
import '../utils/api_error_model.dart';
import '../utils/api.dart';

class QuestionsController extends GetxController {
  int currentPage = 1;
  final int limit = 30;
  bool hasMore = true;
  bool loadingQuestions = false;
  bool isOpen = false;

  List questions = [];
  ApiErrorModel? errorModel;

  @override
  void onInit() {
    getQuestions();
    super.onInit();
  }

  void checkOpened(bool value) {
    isOpen = value;
    update();
  }

  Future<void> getQuestions({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      questions.clear();
    }

    if (!hasMore || loadingQuestions) return;

    loadingQuestions = true;
    update();

    await API().get(
      url: '/questions?limit=$limit&page=$currentPage',
      onResponse: (response) {
        loadingQuestions = false;

        if (response.statusCode == 200 && response.data['success']) {
          List newQuestions = response.data['data'];
          final pagination = response.data['pagination'];

          questions.addAll(newQuestions);
          update();

          final int totalPages = pagination['pages'] ?? 1;

          if (currentPage < totalPages) {
            currentPage += 1;
          } else {
            hasMore = false;
          }
        }

        update();
      },
      onError: (error) {
        loadingQuestions = false;
        errorModel = error;
        update();
      },
    );

    loadingQuestions = false;
    update();
  }
}
