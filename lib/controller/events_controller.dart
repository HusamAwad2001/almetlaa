import 'package:get/get.dart';

import '../utils/api.dart';
import '../utils/api_error_model.dart';

class EventsController extends GetxController {
  @override
  void onInit() {
    getEvents();
    super.onInit();
  }

  List events = [];
  bool loadingEvents = false;
  bool hasMore = true;
  int currentPage = 1;
  final int limit = 20;
  ApiErrorModel? errorModel;

  Future<void> getEvents({bool isRefresh = false}) async {
    if (loadingEvents) return;

    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      events.clear();
    }

    if (!hasMore) return;

    loadingEvents = true;
    update();

    await API().get(
      url: '/events?page=$currentPage&limit=$limit',
      onResponse: (response) {
        if (response.statusCode == 200 && response.data['success']) {
          List newItems = response.data['data'];
          final pagination = response.data['pagination'];

          events.addAll(newItems);

          final int totalPages = pagination['pages'] ?? 1;
          currentPage++;

          if (currentPage > totalPages || newItems.length < limit) {
            hasMore = false;
          }
        } else {
          hasMore = false;
        }

        loadingEvents = false;
        update();
      },
      onError: (error) {
        errorModel = error;
        loadingEvents = false;
        update();
      },
    );
  }

  searchEvents(String search) {
    loadingEvents = true;
    update();
    API().get(
        url: '/events?limit=100&search=$search',
        onResponse: (response) {
          loadingEvents = false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              events = response.data['data'];
            }
          }
          update();
        });
  }
}
