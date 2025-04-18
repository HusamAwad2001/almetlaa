import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
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

  // Future<void> saveNetworkImage(String imageUrl) async {
  //   try {
  //     if (!await Permission.storage.request().isGranted) {
  //       Snack().show(type: false, message: "مطلوب صلاحية الوصول للتخزين");
  //       return;
  //     }
  //     LoadingDialog().dialog();
  //     final response = await Dio().get(
  //       imageUrl,
  //       options: Options(responseType: ResponseType.bytes),
  //     );
  //     final result = await ImageGallerySaver.saveImage(
  //       Uint8List.fromList(response.data),
  //       quality: 100,
  //       name: "image_${DateTime.now().millisecondsSinceEpoch}",
  //     );

  //     Get.back();

  //     if (result['isSuccess'] == true || result['filePath'] != null) {
  //       Snack().show(type: true, message: "تم الحفظ في مكتبة الصور");
  //     } else {
  //       Snack().show(type: false, message: "فشل في حفظ الصورة");
  //     }
  //   } catch (e) {
  //     Get.back();
  //     Snack().show(type: false, message: "حدث خطأ أثناء الحفظ");
  //   }
  // }

  Future<void> saveNetworkImage(String imageUrl) async {
    try {
      final status = await Permission.manageExternalStorage.request();

      if (status.isPermanentlyDenied) {
        await showDialog(
          context: Get.context!,
          builder: (_) => AlertDialog(
            title: Text("الصلاحيات مطلوبة"),
            content: Text("يرجى تفعيل صلاحية التخزين من إعدادات التطبيق."),
            actions: [
              TextButton(
                child: Text("فتح الإعدادات"),
                onPressed: () {
                  openAppSettings();
                  Get.back();
                },
              ),
              TextButton(
                child: Text("إلغاء"),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
        return;
      } else if (status.isDenied) {
        Snack().show(type: false, message: "مطلوب صلاحية الوصول للتخزين");
        return;
      }

      LoadingDialog().dialog();

      final response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            double progress = received / total;
            print("Download progress: ${(progress * 100).toStringAsFixed(0)}%");
          }
        },
      );

      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.data);

      bool success = await GallerySaver.saveImage(file.path) ?? false;

      Get.back();

      if (success) {
        Snack().show(type: true, message: "تم حفظ الصورة في المعرض");
      } else {
        Snack().show(type: false, message: "حذث خطأ أثناء حفظ الصورة");
      }
    } catch (e) {
      Get.back();
      Snack().show(type: false, message: "حدث خطأ أثناء الحفظ");
    }
  }
}
