import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../core/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import '../routes/routes.dart';
import '../utils/api.dart';
import '../utils/api_error_model.dart';
import '../views/widgets/loading_dialog.dart';
import '../views/widgets/snack.dart';

class AllowanceController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final viewController = TextEditingController();
  final imageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getAllExchange();
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !loadingExchange &&
        hasMoreExchange) {
      getAllExchange();
    }
  }

  bool isGrid = false;

  void switchGridStyle() {
    isGrid = !isGrid;
    update();
  }

  List listAllExchange = [];
  bool loadingExchange = false;
  bool hasMoreExchange = true;
  int exchangeCurrentPage = 1;
  final int exchangeLimit = 8;
  ApiErrorModel? errorModel;

  Future<void> getAllExchange({bool isRefresh = false}) async {
    if (isRefresh) {
      exchangeCurrentPage = 1;
      hasMoreExchange = true;
      listAllExchange.clear();
    }

    if (!hasMoreExchange || loadingExchange) return;

    loadingExchange = true;
    update();

    await API().get(
      url: '/exchange?limit=$exchangeLimit&page=$exchangeCurrentPage',
      onResponse: (response) {
        loadingExchange = false;

        if (response.statusCode == 200 && response.data['success']) {
          List newData = response.data['data'];
          final pagination = response.data['pagination'];
          listAllExchange.addAll(newData);

          final int totalPages = pagination['pages'] ?? 1;

          if (exchangeCurrentPage < totalPages) {
            exchangeCurrentPage += 1;
          } else {
            hasMoreExchange = false;
          }
        }
        errorModel = null;
        update();
      },
      onError: (error) {
        loadingExchange = false;
        errorModel = error;
        update();
      },
    );
  }

  searchExchange(String search) {
    loadingExchange = true;
    update();
    API().get(
        url: '/exchange?limit=100&search=$search',
        onResponse: (response) {
          loadingExchange = false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              listAllExchange = response.data['data'];
            }
          }
          update();
        });
  }

  Map data = {};
  bool loadingExchangeById = true;
  getOneExchangeById(String id) {
    API().get(
      url: '/exchange/$id',
      onResponse: (response) {
        loadingExchangeById = false;
        if (response.statusCode == 200) {
          data = response.data['data'];
        }
        update();
      },
    );
  }

  String extractDate(String datetime) {
    return datetime.substring(0, 10);
  }

  /// ---------------- CREATE EXCHANGE ----------------

  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  Future<void> pickImage() async {
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      final originalFile = File(_pickedFile!.path);
      final originalSizeBytes = await originalFile.length();
      final originalSizeMB = originalSizeBytes / (1024 * 1024);
      debugPrint('📷 Original size: ${originalSizeMB.toStringAsFixed(2)} MB');

      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        _pickedFile!.path,
        '${_pickedFile!.path}_compressed.jpg',
        quality: 70,
      );

      if (compressedImage != null) {
        final compressedSizeBytes = await compressedImage.length();
        final compressedSizeMB = compressedSizeBytes / (1024 * 1024);
        debugPrint(
            '🗜️ Compressed size: ${compressedSizeMB.toStringAsFixed(2)} MB');

        imageFile = File(compressedImage.path);
      } else {
        debugPrint('⚠️ Compression failed, using original image');
        imageFile = originalFile;
      }

      imageController.text = extractImageName(_pickedFile!.name);
    }
    update();
  }

  String extractImageName(String path) {
    List<String> parts = path.split('.');
    parts.removeLast();
    String imageName = parts.last;
    return imageName;
  }

  bool loadingCreateBill = true;
  createExchange() async {
    FocusManager.instance.primaryFocus?.unfocus();
    dio.FormData formData = dio.FormData.fromMap({
      'title': titleController.text,
      'description': descriptionController.text,
      'image': await dio.MultipartFile.fromFile(
        imageFile!.path,
        filename: 'image',
      ),
      'user': Global.user['id'],
    });
    LoadingDialog().dialog();
    API().post(
      url: '/exchange',
      body: formData,
      onResponse: (response) {
        loadingCreateBill = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            listAllExchange.insert(0, response.data['data']);
            Get.back();
            Get.back();
            Snack().show(type: true, message: 'تم إنشاء البدل');
            titleController.clear();
            descriptionController.clear();
            imageController.clear();
            viewController.clear();
          }
        }
        update();
      },
    );
  }

  validate() {
    if (Global.token.isEmpty || Global.user.isEmpty) {
      Snack().show(type: false, message: 'يرجى تسجيل الدخول');
      Get.offAllNamed(Routes.loginPage);
      return;
    }
    if (imageController.text.trim().isEmpty) {
      Snack().show(type: false, message: 'يرجى إرفاق صورة');
      return;
    }

    if (titleController.text.trim().isEmpty) {
      Snack().show(type: false, message: 'يرجى كتابة العنوان');
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      Snack().show(type: false, message: 'يرجى كتابة الوصف');
      return;
    }
    createExchange();
  }
}
