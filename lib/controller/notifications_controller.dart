import 'dart:developer';

import '../../views/widgets/loading_dialog.dart';
import 'package:get/get.dart';

import '../utils/api.dart';

class NotificationsController extends GetxController {
  @override
  void onInit() {
    getAllNotifications();
    super.onInit();
  }

  List notifications = [];
  bool loadingNotifications = true;
  getAllNotifications() {
    loadingNotifications = true;
    API().get(
      url: '/alerts/user?limit=100',
      onResponse: (response) {
        loadingNotifications = false;
        log(response.data.toString());
        if (response.statusCode == 200) {
          if (response.data['success']) {
            notifications = response.data['data'];
          }
        }
        update();
      },
    );
  }

  deleteNotification(String id, int index) async {
    LoadingDialog().dialog();
    API().post(
      url: '/alerts/$id',
      body: {},
      onResponse: (response) {
        if (response.statusCode == 200) {
          if (response.data['success']) {
            notifications.removeAt(index);
          }
        }
        Get.back();
        update();
      },
    );
  }

  deleteAll() async {
    LoadingDialog().dialog();
    API().put(
      url: '/alerts/user',
      body: {},
      onResponse: (response) {
        if (response.statusCode == 200) {
          if (response.data['success']) {
            notifications.clear();
          }
        }
        Get.back();
        update();
      },
    );
  }
}
