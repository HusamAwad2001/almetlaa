import 'package:get/get.dart';

import '../utils/api.dart';

class NewsController extends GetxController{

  @override
  void onInit() {
    getNews();
    super.onInit();
  }

  List news=[];
  bool loadingNews=true;
  getNews(){
    loadingNews=true;
    update();
    API().get(
        url: '/news?limit=100',
        onResponse: (response) {
          loadingNews=false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              news = response.data['data'];
            }
          }
          update();
        });
  }

  searchNews(String search){
    loadingNews=true;
    update();
    API().get(
        url: '/news?limit=100&search=$search',
        onResponse: (response) {
          loadingNews=false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              news = response.data['data'];
            }
          }
          update();
        });
  }
}