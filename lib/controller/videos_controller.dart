import 'package:get/get.dart';

import '../utils/api.dart';

class VideosController extends GetxController{

  @override
  void onInit() {
    getVideos();
    super.onInit();
  }

  List videos=[];
  bool loadingVideos=true;
  getVideos(){
    loadingVideos=true;
    update();
    API().get(
        url: '/video?limit=100',
        onResponse: (response) {
          loadingVideos=false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              videos = response.data['data'];
            }
          }
          update();
        });
  }

  searchVideos(String search){
    loadingVideos=true;
    update();
    API().get(
        url: '/video?limit=100&search=$search',
        onResponse: (response) {
          loadingVideos=false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              videos = response.data['data'];
            }
          }
          update();
        });
  }
}