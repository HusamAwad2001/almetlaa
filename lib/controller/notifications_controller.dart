import 'package:get/get.dart';

import '../utils/api.dart';
import '../utils/api_error_model.dart';
import '../../views/widgets/loading_dialog.dart';

class NotificationsController extends GetxController {
  List notifications = [];
  bool loadingNotifications = false;
  bool hasMore = true;
  int currentPage = 1;
  final int limit = 20;
  ApiErrorModel? errorModel;

  @override
  void onInit() {
    getAllNotifications();
    super.onInit();
  }

  Future<void> getAllNotifications({bool isRefresh = false}) async {
    if (loadingNotifications) return;

    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      notifications.clear();
    }

    if (!hasMore) return;

    loadingNotifications = true;
    update();

    await API().get(
      url: '/alerts/user?page=$currentPage&limit=$limit',
      onResponse: (response) {
        if (response.statusCode == 200 && response.data['success']) {
          List newItems = response.data['data'];
          final pagination = response.data['pagination'];

          notifications.addAll(newItems);

          if (pagination != null) {
            final int totalPages = pagination['pages'] ?? 1;
            currentPage++;

            if (currentPage > totalPages || newItems.length < limit) {
              hasMore = false;
            }
          } else {
            hasMore = false;
          }
        } else {
          hasMore = false;
        }

        loadingNotifications = false;
        update();
      },
      onError: (error) {
        errorModel = error;
        loadingNotifications = false;
        update();
      },
    );
  }

  Future<void> deleteNotification(String id, int index) async {
    LoadingDialog().dialog();

    await API().post(
      url: '/alerts/$id',
      body: {},
      onResponse: (response) {
        Get.back();

        if (response.statusCode == 200 && response.data['success']) {
          notifications.removeAt(index);
          update();
        }
      },
      onError: (error) {
        Get.back();
        errorModel = error;
        update();
      },
    );
  }

  Future<void> deleteAll() async {
    LoadingDialog().dialog();

    await API().put(
      url: '/alerts/user',
      body: {},
      onResponse: (response) {
        Get.back();

        if (response.statusCode == 200 && response.data['success']) {
          notifications.clear();
          update();
        }
      },
      onError: (error) {
        Get.back();
        errorModel = error;
        update();
      },
    );
  }
}
