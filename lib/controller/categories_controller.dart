import 'package:get/get.dart';
import '../utils/api.dart';

class CategoriesController extends GetxController{

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  List categories=[];
  bool loadingCategories=true;
  getCategories(){
    API().get(
        url: '/categories?limit=100',
        onResponse: (response) {
          loadingCategories=false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              categories = response.data['data'];
            }
          }
          update();
        });
  }
}