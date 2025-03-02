import 'package:get/get.dart';

import '../utils/api.dart';

class VideoDetailsController extends GetxController{

  Map item=Get.arguments[0];
  List videos=Get.arguments[1];

  @override
  void onInit(){
    super.onInit();
    addView();
  }

  bool loading=true;
  addView(){
    API().post(
        body: {},
        url: '/video/views/${item["_id"]}',
        onResponse: (response) {
          if(response.data["success"]){
            item['views']=response.data['data'];
          }
          loading=false;
          update();
        });
  }
}