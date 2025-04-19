import 'package:dio/dio.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

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
      LoadingDialog().dialog();

      final tempDir = await getTemporaryDirectory();
      final path =
          '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await Dio().download(
        imageUrl,
        path,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = received / total;
            print("Download progress: ${(progress * 100).toStringAsFixed(0)}%");
          }
        },
      );

      await GallerySaver.saveImage(path, albumName: 'Baiti') ?? false;
      Get.back();
      Snack().show(type: true, message: "تم حفظ الصورة في المعرض");
    } catch (e) {
      Get.back();
      Snack().show(type: false, message: "حدث خطأ أثناء حفظ الصورة");
    }
  }
}
