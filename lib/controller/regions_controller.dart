import 'package:get/get.dart';

import '../utils/api.dart';

class RegionsController extends GetxController {
  @override
  void onInit() {
    getAllRegions();
    super.onInit();
  }

  List listAllRegions = [];
  bool loadingRegions = true;
  getAllRegions() {
    loadingRegions = true;
    update();
    API().get(
      url: '/regions?limit=100',
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
