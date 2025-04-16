import 'package:get/get.dart';

import '../utils/api.dart';
import '../utils/api_error_model.dart';

class RegionsController extends GetxController {
  @override
  void onInit() {
    getAllRegions();
    super.onInit();
  }

  List listAllRegions = [];
  bool loadingRegions = false;
  bool hasMore = true;
  int currentPage = 1;
  int limit = 20;
  ApiErrorModel? errorModel;

  Future<void> getAllRegions({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      listAllRegions.clear();
    }

    if (!hasMore || loadingRegions) return;

    loadingRegions = true;
    update();

    await API().get(
      url: '/regions?page=$currentPage&limit=$limit',
      onResponse: (response) {
        loadingRegions = false;

        if (response.statusCode == 200 && response.data['success']) {
          List newItems = response.data['data'];
          final pagination = response.data['pagination'];

          listAllRegions.addAll(newItems);

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
        loadingRegions = false;
        errorModel = error;
        update();
      },
    );
  }

  searchRegions(String search) {
    loadingRegions = true;
    update();
    API().get(
      url: '/regions?limit=100&search=$search',
      onResponse: (response) {
        loadingRegions = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            listAllRegions = response.data['data'];
          }
        }
        update();
      },
    );
  }
}
