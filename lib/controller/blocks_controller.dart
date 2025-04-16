import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../views/widgets/loading_dialog.dart';
import '../../views/widgets/snack.dart';
import 'package:get/get.dart';

import '../utils/api.dart';
import '../utils/api_error_model.dart';

class BlocksController extends GetxController {
  List listBlocks = [];
  bool loadingBlocks = false;
  bool hasMore = true;
  int currentPage = 1;
  final int limit = 20;
  ApiErrorModel? errorModel;

  @override
  void onInit() {
    getBlocks();
    super.onInit();
  }

  Future<void> getBlocks({bool isRefresh = false}) async {
    if (loadingBlocks) return;

    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      listBlocks.clear();
    }

    if (!hasMore) return;

    loadingBlocks = true;
    update();

    await API().get(
      url: '/widgets/?page=$currentPage&limit=$limit&region=${Get.arguments}',
      onResponse: (response) {
        if (response.statusCode == 200 && response.data['success']) {
          List newItems = response.data['data'];
          final pagination = response.data['pagination'];

          listBlocks.addAll(newItems);

          final int totalPages = pagination['pages'] ?? 1;
          currentPage++;

          if (currentPage > totalPages || newItems.length < limit) {
            hasMore = false;
          }
        } else {
          hasMore = false;
        }

        loadingBlocks = false;
        update();
      },
      onError: (error) {
        errorModel = error;
        loadingBlocks = false;
        update();
      },
    );
  }

  Future<void> saveNetworkImage(String imageUrl) async {
    try {
      if (!await Permission.storage.request().isGranted) {
        Snack().show(type: false, message: "مطلوب صلاحية الوصول للتخزين");
        return;
      }
      LoadingDialog().dialog();
      final response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: "image_${DateTime.now().millisecondsSinceEpoch}",
      );

      Get.back();

      if (result['isSuccess'] == true || result['filePath'] != null) {
        Snack().show(type: true, message: "تم الحفظ في مكتبة الصور");
      } else {
        Snack().show(type: false, message: "فشل في حفظ الصورة");
      }
    } catch (e) {
      Get.back();
      Snack().show(type: false, message: "حدث خطأ أثناء الحفظ");
    }
  }
}
