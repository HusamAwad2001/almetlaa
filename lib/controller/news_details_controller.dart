import 'package:get/get.dart';

class NewsDetailsController extends GetxController {
  Map item = Get.arguments;

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
