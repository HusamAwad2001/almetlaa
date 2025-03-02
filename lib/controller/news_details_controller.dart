import 'package:get/get.dart';

import '../utils/api.dart';

class NewsDetailsController extends GetxController{

  Map item=Get.arguments;

  @override
  void onInit(){
    super.onInit();
    addView();
  }

  bool loading=true;
  addView(){
    API().post(
        body: {},
        url: '/news/views/${item["_id"]}',
        onResponse: (response) {
          if(response.data["success"]){
            item['views']=response.data['data'];
          }
          loading=false;
          update();
        });
  }
}