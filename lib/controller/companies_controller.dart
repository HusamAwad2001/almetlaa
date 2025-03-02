import 'package:get/get.dart';
import '../utils/api.dart';

class CompaniesController extends GetxController{

  Map category=Get.arguments;

  @override
  void onInit() {
    getCompanies();
    super.onInit();
  }

  List companies=[];
  bool loadingCompanies=true;
  getCompanies(){
    API().get(
        url: '/company?limit=100&category=${category['_id']}',
        onResponse: (response) {
          loadingCompanies=false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              companies = response.data['data'];
            }
          }
          update();
        });
  }
}