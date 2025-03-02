// import 'dart:io';
//
// import 'package:almetlaa/utils/api.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../core/global.dart';
// import '../routes/routes.dart';
// import '../views/widgets/loading_dialog.dart';
// import '../views/widgets/snack.dart';
//
// class CreateSurplusesController extends GetxController {
//   final nameController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final priceController = TextEditingController();
//   final biddingPeriodController = TextEditingController();
//   final imageController = TextEditingController();
//
//   createSurpluses() async {
//     FocusManager.instance.primaryFocus?.unfocus();
//     dio.FormData formData = dio.FormData.fromMap({
//       'name': nameController.text,
//       'description': descriptionController.text,
//       'image': await dio.MultipartFile.fromFile(
//         imageFile!.path,
//         filename: 'image',
//       ),
//       'price': int.parse(priceController.text),
//       'biddingPeriod': int.parse(biddingPeriodController.text),
//     });
//     LoadingDialog().dialog();
//     API().post(
//       url: '/surplusGoods',
//       body: formData,
//       onResponse: (response) {
//         if (response.statusCode == 200) {
//           if (response.data['success']) {
//             Get.back();
//             Snack().show(type: true, message: 'تمت الإضافة');
//             clear();
//           }
//         }
//         update();
//       },
//     );
//   }
//
//   validate() {
//     if (Global.token.isEmpty || Global.user.isEmpty) {
//       Snack().show(type: false, message: 'يرجى تسجيل الدخول');
//       Get.offAllNamed(Routes.loginPage);
//       return;
//     }
//     if (nameController.text.isEmpty) {
//       Snack().show(type: false, message: 'يرجى إضافة العنوان');
//       return;
//     }
//     if (descriptionController.text.isEmpty) {
//       Snack().show(type: false, message: 'يرجى إضافة الوصف');
//       return;
//     }
//     if (priceController.text.isEmpty) {
//       Snack().show(type: false, message: 'يرجى إضافة السعر');
//       return;
//     }
//     if (biddingPeriodController.text.isEmpty) {
//       Snack().show(type: false, message: 'يرجى إضافة وقت المزايدة');
//       return;
//     }
//     if (imageController.text.isEmpty) {
//       Snack().show(type: false, message: 'يرجى إختيار صورة');
//       return;
//     }
//     createSurpluses();
//   }
//
//   XFile? _pickedFile;
//   final ImagePicker _picker = ImagePicker();
//   File? imageFile;
//
//   Future<void> pickImage() async {
//     _pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (_pickedFile != null) {
//       imageFile = File(_pickedFile!.path);
//       imageController.text = extractImageName(_pickedFile!.name);
//     }
//     update();
//   }
//
//   String extractImageName(String path) {
//     List<String> parts = path.split('.');
//     parts.removeLast();
//     String imageName = parts.last;
//     return imageName;
//   }
//
//   clear() {
//     nameController.clear();
//     descriptionController.clear();
//     priceController.clear();
//     biddingPeriodController.clear();
//     imageController.clear();
//   }
// }
