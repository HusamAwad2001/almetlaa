import 'package:get/get.dart';

import '../utils/api.dart';
import '../utils/api_error_model.dart';

class NewsController extends GetxController {
  @override
  void onInit() {
    getNews();
    super.onInit();
  }

  List news = [];
  bool loadingNews = false;
  bool hasMore = true;
  int currentPage = 1;
  int limit = 20;
  ApiErrorModel? errorModel;

  Future<void> getNews({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      news.clear();
    }

    if (!hasMore || loadingNews) return;

    loadingNews = true;
    update();

    await API().get(
      url: '/news?page=$currentPage&limit=$limit',
      onResponse: (response) {
        loadingNews = false;

        if (response.statusCode == 200 && response.data['success']) {
          List newItems = response.data['data'];
          final pagination = response.data['pagination'];

          news.addAll(newItems);

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
        loadingNews = false;
        errorModel = error;
        update();
      },
    );

    loadingNews = false;
    update();
  }

  Future<void> searchNews(String search) async {
    loadingNews = true;
    update();
    await API().get(
      url: '/news?limit=100&search=$search',
      onResponse: (response) {
        loadingNews = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            news = response.data['data'];
          }
        }
      },
      onError: (error) {},
    );
    loadingNews = false;
    update();
  }
}
