import 'dart:io';
import 'package:almetlaa/views/widgets/loading_dialog.dart';
import 'package:almetlaa/views/widgets/snack.dart';
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

  getAllBills() {
    API().get(
      url: '/bills/total',
      onResponse: (response) {
        loadingBills = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            listAllBills = response.data['data'];
            totalAmount = response.data['totalAmount'];
          }
        }
        update();
      },
    );
  }

  List listMyBills = [];
  bool loadingMyBills = true;

  getMyBills(String id) {
    loadingMyBills=true;
    update();
    API().get(
      url: '/bills/mybills?item=$id',
      onResponse: (response) {
        loadingMyBills = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            listMyBills = response.data['data'];
            itemId = id;
          }
        }
        update();
      },
    );
  }

  bool loadingCreateBill = true;

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
        loadingCreateBill = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            Get.back();
            Get.back();
            Snack().show(type: true, message: 'تم إنشاء الفاتورة');
            batchTypeController.clear();
            amountController.clear();
            dateController.clear();
            imageController.clear();
            listMyBills.add(response.data['data']);
            int s = response.data['data']['amount'];
            totalAmount = totalAmount + s;
            for (var element in listAllBills) {
              if (element['_id'] == itemId) {
                element['total'] += s;
              }
            }
          }
        }
        update();
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
          listAllBills.forEach((element) {
            if (element['_id'] == itemId) {
              element['total'] -= s;
            }
          });
          listMyBills.removeAt(index);
          if (response.data['success']) {
            Snack().show(type: true, message: 'تم حذف الفاتورة');
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
    if (batchTypeController.text.trim().isEmpty) {
      Snack().show(type: false, message: 'يرجى كتابة نوع الدفعة');
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
    _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      imageFile = File(_pickedFile!.path);
      imageController.text = extractImageName(_pickedFile!.name);
    } else {
      Snack().show(type: false, message: 'يجب اختيار الصورة');
    }
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
    } else {
      Snack().show(type: false, message: 'يجب اختيار التاريخ');
    }
    update();
  }
}
