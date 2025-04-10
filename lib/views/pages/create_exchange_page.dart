import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controller/allowance_controller.dart';
import '../widgets/text_field_widget.dart';

class CreateExchangePage extends StatelessWidget {
  const CreateExchangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          'إضافة بدل',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      // body: GetBuilder<AllowanceController>(
      //   init: AllowanceController(),
      //   builder: (controller) {
      //     return Column(
      //       children: [
      //         InkWell(
      //           onTap: () {
      //             FocusManager.instance.primaryFocus?.unfocus();
      //             controller.pickImage();
      //           },
      //           child: TextFieldWidget(
      //             controller: controller.imageController,
      //             label: 'ارفاق صورة',
      //             enabled: false,
      //             radius: 10.r,
      //             labelColor: const Color(0xFFB0B0B0),
      //             hintFontWeight: FontWeight.bold,
      //             suffixIcon: Container(
      //               padding: EdgeInsets.all(15.w),
      //               child: SvgPicture.asset('assets/images/select_image.svg'),
      //             ),
      //           ),
      //         ),
      //         15.ph,
      //         TextFieldWidget(
      //           controller: controller.titleController,
      //           label: 'العنوان',
      //           radius: 10.r,
      //           labelColor: const Color(0xFFB0B0B0),
      //           hintFontWeight: FontWeight.bold,
      //         ),
      //         15.ph,
      //         TextFieldWidget(
      //           controller: controller.descriptionController,
      //           label: 'الوصف',
      //           radius: 10.r,
      //           maxLines: 5,
      //           labelColor: const Color(0xFFB0B0B0),
      //           hintFontWeight: FontWeight.bold,
      //         ),
      //         const Spacer(),
      //         FloatingActionButton(
      //           onPressed: () => controller.validate(),
      //           backgroundColor: Constants.primaryColor,
      //           child: const Icon(Icons.add),
      //         ),
      //       ],
      //     );
      //   },
      // ).paddingSymmetric(vertical: 50.h, horizontal: 30.w),
      body: GetBuilder<AllowanceController>(
        init: AllowanceController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 📸 اختيار صورة
                GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    controller.pickImage();
                  },
                  child: AbsorbPointer(
                    child: TextFieldWidget(
                      controller: controller.imageController,
                      label: 'إرفاق صورة',
                      enabled: false,
                      radius: 12.r,
                      labelColor: const Color(0xFFB0B0B0),
                      hintFontWeight: FontWeight.bold,
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(14.w),
                        child:
                            SvgPicture.asset('assets/images/select_image.svg'),
                      ),
                    ),
                  ),
                ),
                20.ph,

                /// 📝 عنوان الإضافة
                TextFieldWidget(
                  controller: controller.titleController,
                  label: 'العنوان',
                  radius: 12.r,
                  labelColor: const Color(0xFFB0B0B0),
                  hintFontWeight: FontWeight.bold,
                ),
                20.ph,

                /// 🖋️ وصف الإضافة
                TextFieldWidget(
                  controller: controller.descriptionController,
                  label: 'الوصف',
                  radius: 12.r,
                  maxLines: 5,
                  labelColor: const Color(0xFFB0B0B0),
                  hintFontWeight: FontWeight.bold,
                ),
                30.ph,

                ElevatedButton.icon(
                  onPressed: controller.validate,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                  label: const Text(
                    "إضافة",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'amarai',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.h),
                    backgroundColor: Constants.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: 30.h, horizontal: 24.w),
          );
        },
      ),
    );
  }
}
