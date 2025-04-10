import '../../views/widgets/loading_dialog.dart';
import '../../views/widgets/snack.dart';
import 'package:get/get.dart';

import '../utils/api.dart';

class BlocksController extends GetxController {
  @override
  void onInit() {
    getBlocks();
    super.onInit();
  }

  List listBlocks = [];
  bool loadingBlocks = true;
  getBlocks() {
    loadingBlocks = true;
    update();
    API().get(
      url: '/widgets/?limit=100&region=${Get.arguments}',
      onResponse: (response) {
        loadingBlocks = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            listBlocks = response.data['data'];
          }
        }
        update();
      },
    );
  }

  saveNetworkImage(String image) async {
    LoadingDialog().dialog();
    // var response = await Dio().get(
    //     image,
    //     options: Options(responseType: ResponseType.bytes));
    // final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),);
    Get.back();
    Snack().show(type: true, message: "تم الحفظ في مكتبة الصور");
  }
}
