import 'package:get/get.dart';
import '../utils/api.dart';
import '../utils/api_error_model.dart';

class CategoriesController extends GetxController {
  List categories = [];
  bool loadingCategories = false;
  bool hasMore = true;
  int currentPage = 1;
  final int limit = 20;
  ApiErrorModel? errorModel;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> getCategories({bool isRefresh = false}) async {
    if (loadingCategories) return;

    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      categories.clear();
    }

    if (!hasMore) return;

    loadingCategories = true;
    update();

    await API().get(
      url: '/categories?page=$currentPage&limit=$limit',
      onResponse: (response) {
        if (response.statusCode == 200 && response.data['success']) {
          List newItems = response.data['data'];
          final pagination = response.data['pagination'];

          categories.addAll(newItems);

          final int totalPages = pagination['pages'] ?? 1;
          currentPage++;

          if (currentPage > totalPages || newItems.length < limit) {
            hasMore = false;
          }
        } else {
          hasMore = false;
        }

        loadingCategories = false;
        update();
      },
      onError: (error) {
        errorModel = error;
        loadingCategories = false;
        update();
      },
    );
  }
}
