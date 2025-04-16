import 'package:get/get.dart';

class NewsDetailsController extends GetxController {
  late Map<String, dynamic> item;

  @override
  void onInit() {
    super.onInit();
    item = Get.arguments;
  }

  // bool loading = true;
  // addView() {
  //   API().post(
  //     body: {},
  //     url: '/news/views/${item["_id"]}',
  //     onResponse: (response) {
  //       if (response.data["success"]) {
  //         item['views'] = response.data['data'];
  //       }
  //       loading = false;
  //       update();
  //     },
  //   );
  // }
}
