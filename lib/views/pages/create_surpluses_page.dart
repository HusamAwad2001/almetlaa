import 'package:flutter/services.dart';

import '../../controller/surpluses_controller.dart';
import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../widgets/text_field_widget.dart';

class CreateSurplusesPage extends GetView<SurplusesController> {
  const CreateSurplusesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text('إضافة فوائض', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
            controller.clear();
          },
        ).paddingOnly(right: 10.w),
      ),
      body: GetBuilder<SurplusesController>(
        init: SurplusesController(),
        builder: (controller) {
          return Column(
            children: [
              TextFieldWidget(
                controller: controller.nameController,
                label: 'العنوان',
                radius: 10.r,
                labelColor: const Color(0xFFB0B0B0),
                hintFontWeight: FontWeight.bold,
              ),
              15.ph,
              TextFieldWidget(
                controller: controller.descriptionController,
                label: 'الوصف',
                radius: 10.r,
                labelColor: const Color(0xFFB0B0B0),
                hintFontWeight: FontWeight.bold,
                maxLines: 3,
              ),
              15.ph,
              TextFieldWidget(
                controller: controller.priceController,
                label: 'السعر',
                textInputType: TextInputType.number,
                radius: 10.r,
                labelColor: const Color(0xFFB0B0B0),
                hintFontWeight: FontWeight.bold,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
              ),
              15.ph,
              TextFieldWidget(
                controller: controller.biddingPeriodController,
                label: 'عدد أيام المزايدة',
                textInputType: TextInputType.number,
                radius: 10.r,
                labelColor: const Color(0xFFB0B0B0),
                hintFontWeight: FontWeight.bold,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                ],
              ),
              15.ph,
              GestureDetector(
                onTap: controller.pickImage,
                child: TextFieldWidget(
                  controller: controller.imageController,
                  label: 'ارفاق صورة',
                  enabled: false,
                  radius: 10.r,
                  labelColor: const Color(0xFFB0B0B0),
                  hintFontWeight: FontWeight.bold,
                  suffixIcon: Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/select_image.svg',
                      width: 24.w,
                      height: 24.h,
                      color: Colors.white,
                    ),
                  ).paddingOnly(left: 10.w),
                ),
              ),
              const Spacer(),
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
          );
        },
      ).paddingSymmetric(vertical: 50.h, horizontal: 30.w),
    );
  }
}
