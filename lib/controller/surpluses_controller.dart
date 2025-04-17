import 'dart:async';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../utils/api_error_model.dart';
import '../../utils/api.dart';
import '../core/global.dart';
import '../routes/routes.dart';
import '../views/widgets/loading_dialog.dart';
import '../views/widgets/snack.dart';

class SurplusesController extends GetxController {
  @override
  void onInit() {
    getAllSurpluses();
    super.onInit();
  }

  final searchController = TextEditingController();

  Map<String, Duration> remainingTimeMap = {};
  final Map<String, Timer> _timers = {};
  void startCountdownForItem(String id, int initialSeconds) {
    _timers[id]?.cancel();

    remainingTimeMap[id] = Duration(seconds: initialSeconds);

    _timers[id] = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = remainingTimeMap[id];
      if (current == null || current.inSeconds <= 1) {
        timer.cancel();
        remainingTimeMap[id] = Duration.zero;
      } else {
        remainingTimeMap[id] = current - const Duration(seconds: 1);
      }
      update(['countdown-$id']);
    });
  }

  void initCountdowns(List items) {
    for (final item in items) {
      final id = item['_id'];
      final seconds = int.tryParse(item['remainingTime'].toString()) ?? 0;
      if (id != null && seconds > 0) {
        startCountdownForItem(id, seconds);
      }
    }
  }

  List surpluses = [];
  bool loadingSurpluses = false;
  bool hasMore = true;
  int currentPage = 1;
  final int limit = 20;
  ApiErrorModel? errorModel;

  Future<void> getAllSurpluses({bool isRefresh = false}) async {
    if (loadingSurpluses) return;

    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      surpluses.clear();
    }

    if (!hasMore) return;

    loadingSurpluses = true;
    update();

    await API().get(
      url: '/surplusGoods?page=$currentPage&limit=$limit',
      onResponse: (response) {
        if (response.statusCode == 200 && response.data['success']) {
          List newItems = response.data['data'];
          final pagination = response.data['pagination'];

          surpluses.addAll(newItems);
          initCountdowns(surpluses);

          final int totalPages = pagination['pages'] ?? 1;
          currentPage++;

          if (currentPage > totalPages || newItems.length < limit) {
            hasMore = false;
          }
        } else {
          hasMore = false;
        }

        loadingSurpluses = false;
        errorModel = null;
        update();
      },
      onError: (error) {
        errorModel = error;
        loadingSurpluses = false;
        update();
      },
    );
  }

  searchSurpluses(String search) {
    loadingSurpluses = true;
    update();
    API().get(
        url: '/surplusGoods?limit=100&search=$search',
        onResponse: (response) {
          loadingSurpluses = false;
          if (response.statusCode == 200) {
            if (response.data['success']) {
              surpluses = response.data['data'];
            }
          }
          update();
        });
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final biddingPeriodController = TextEditingController();
  final imageController = TextEditingController();

  createSurpluses() async {
    FocusManager.instance.primaryFocus?.unfocus();
    dio.FormData formData = dio.FormData.fromMap({
      'name': nameController.text,
      'description': descriptionController.text,
      'image': await dio.MultipartFile.fromFile(
        imageFile!.path,
        filename: 'image',
      ),
      'price': int.parse(priceController.text),
      'biddingPeriod': int.parse(biddingPeriodController.text) * 24 * 60,
    });
    LoadingDialog().dialog();
    API().post(
      url: '/surplusGoods',
      body: formData,
      onResponse: (response) {
        surpluses = [response.data['data'], ...surpluses];
        Get.back();
        Snack().show(type: true, message: 'تمت الإضافة');
        clear();
        update();
      },
      onError: (error) {
        Get.back();
        Snack().show(type: false, message: error.message ?? 'حدث خطأ ما');
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
    if (nameController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إضافة العنوان');
      return;
    }
    if (descriptionController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إضافة الوصف');
      return;
    }
    if (priceController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إضافة السعر');
      return;
    }
    if (biddingPeriodController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إضافة أيام المزايدة');
      return;
    }
    if (imageController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى إختيار صورة');
      return;
    }
    createSurpluses();
  }

  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  Future<void> pickImage() async {
    LoadingDialog().dialog();
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
    Get.back();
    update();
  }

  String extractImageName(String path) {
    List<String> parts = path.split('.');
    parts.removeLast();
    String imageName = parts.last;
    return imageName;
  }

  clear() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    biddingPeriodController.clear();
    imageController.clear();
    imageFile = null;
    _pickedFile = null;
    update();
  }
}
