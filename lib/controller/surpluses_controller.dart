import 'dart:io';
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

          final int totalPages = pagination['pages'] ?? 1;
          currentPage++;

          if (currentPage > totalPages || newItems.length < limit) {
            hasMore = false;
          }
        } else {
          hasMore = false;
        }

        loadingSurpluses = false;
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
        if (response.statusCode == 200) {
          if (response.data['success']) {
            print('response.data');
            print(response.data['data']);
            surpluses = [response.data['data'], ...surpluses];
            Get.back();
            Get.back();
            Snack().show(type: true, message: 'تمت الإضافة');
            clear();
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
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      imageFile = File(_pickedFile!.path);
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

  clear() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    biddingPeriodController.clear();
    imageController.clear();
  }
}
