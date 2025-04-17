import 'dart:io';
import '../../utils/api_error_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../views/widgets/loading_dialog.dart';
import '../../views/widgets/snack.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../core/global.dart';
import '../routes/routes.dart';
import '../utils/api.dart';

class ConstructionBillsController extends GetxController {
  final batchTypeController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void onInit() {
    getAllBills();
    super.onInit();
  }

  String? itemId;

  List listAllBills = [];
  int totalAmount = 0;
  bool loadingBills = true;
  ApiErrorModel? errorModel;

  getAllBills() {
    loadingBills = true;
    update();
    API().get(
      url: '/bills/total',
      onResponse: (response) {
        loadingBills = false;
        if (response.statusCode == 200 && response.data['success']) {
          listAllBills = response.data['data'];
          totalAmount = response.data['totalAmount'];
        }
        errorModel = null;
        update();
      },
      onError: (errorModel) {
        loadingBills = false;
        this.errorModel = errorModel;
        update();
      },
    );
  }

  List listMyBills = [];
  bool loadingMyBills = true;
  ApiErrorModel? errorModelMyBills;

  getMyBills(String id) {
    loadingMyBills = true;
    update();
    API().get(
      url: '/bills/mybills?item=$id',
      onResponse: (response) {
        loadingMyBills = false;
        errorModelMyBills = null;
        if (response.statusCode == 200 && response.data['success']) {
          listMyBills = response.data['data'];
          itemId = id;
        }
        update();
      },
      onError: (errorModel) {
        loadingMyBills = false;
        errorModelMyBills = errorModel;
        update();
      },
    );
  }

  createBill() async {
    FocusManager.instance.primaryFocus?.unfocus();
    dio.FormData formData = dio.FormData.fromMap({
      'amount': amountController.text,
      'date': dateController.text,
      'batchType': batchTypeController.text,
      'image': await dio.MultipartFile.fromFile(
        imageFile!.path,
        filename: 'image',
      ),
      'item': itemId,
    });
    LoadingDialog().dialog();
    API().post(
      url: '/bills',
      body: formData,
      onResponse: (response) {
        if (response.statusCode == 200 && response.data['success']) {
          Get.back();
          Get.back();
          Snack().show(type: true, message: 'تم إنشاء الفاتورة');
          listMyBills.add(response.data['data']);
          int s = response.data['data']['amount'];
          totalAmount = totalAmount + s;
          for (var element in listAllBills) {
            if (element['_id'] == itemId) {
              element['total'] += s;
            }
          }
        }
        clearData();
        update();
      },
      onError: (errorModel) {
        Get.back();
        update();
        Snack().show(type: false, message: errorModel.message ?? 'حدث خطأ ما');
      },
    );
  }

  deleteBill(dynamic object, int index) {
    LoadingDialog().dialog();
    API().delete(
      url: '/bills/${object['_id']}',
      body: {},
      onResponse: (response) {
        if (response.statusCode == 200) {
          Get.back();
          Get.back();
          int s = object['amount'];
          totalAmount = totalAmount - s;
          for (var element in listAllBills) {
            if (element['_id'] == itemId) {
              element['total'] -= s;
            }
          }
          listMyBills.removeAt(index);
          if (response.data['success']) {
            Snack().show(type: true, message: 'تم حذف الفاتورة');
          }
        }
        update();
      },
      onError: (errorModel) {
        Get.back();
        update();
        Snack().show(type: false, message: errorModel.message ?? 'حدث خطأ ما');
      },
    );
  }

  validate() {
    if (Global.token.isEmpty || Global.user.isEmpty) {
      Snack().show(type: false, message: 'يرجى تسجيل الدخول');
      Get.offAllNamed(Routes.loginPage);
      return;
    }
    if (batchTypeController.text.trim().isEmpty) {
      Snack().show(type: false, message: 'يرجى كتابة اسم الدفعة');
      return;
    }

    if (amountController.text.trim().isEmpty) {
      Snack().show(type: false, message: 'يرجى كتابة المبلغ');
      return;
    }

    if (dateController.text.trim().isEmpty) {
      Snack().show(type: false, message: 'يرجى اختيار التاريخ');
      return;
    }

    if (imageController.text.trim().isEmpty) {
      Snack().show(type: false, message: 'يرجى اختيار الصورة');
      return;
    }
    createBill();
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

  DateTime today = DateTime.now();

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: today,
      firstDate: today,
      lastDate: DateTime(2030),
      confirmText: 'تم',
      cancelText: 'إلغاء',
      helpText: 'اختر التاريخ',
      fieldLabelText: 'أدخل التاريخ',
      errorInvalidText: 'تنسيق غير صالح',
      errorFormatText: 'خطأ في تنسيق النص',
    );
    if (picked != null) {
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
    update();
  }

  clearData() {
    imageFile = null;
    batchTypeController.clear();
    amountController.clear();
    dateController.clear();
    imageController.clear();
    update();
  }
}
