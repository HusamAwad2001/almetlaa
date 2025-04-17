import 'package:flutter/services.dart';

import '../../../values/constants.dart';
import '../../widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controller/construction_bills_controller.dart';

class CreateBatchDialog {
  static show() {
    Get.bottomSheet(
      GetBuilder<ConstructionBillsController>(
        builder: (controller) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 25.h,
              children: [
                5.ph,
                const Text(
                  "دفعة جديدة",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Constants.primaryColor),
                ),
                TextFieldWidget(
                  controller: controller.batchTypeController,
                  label: 'اسم الدفعة',
                  radius: 20.r,
                  labelColor: const Color(0xFFB0B0B0),
                  hintFontWeight: FontWeight.bold,
                ),
                TextFieldWidget(
                  controller: controller.amountController,
                  label: 'المبلغ',
                  textInputType: TextInputType.number,
                  radius: 20.r,
                  labelColor: const Color(0xFFB0B0B0),
                  hintFontWeight: FontWeight.bold,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}$')),
                  ],
                ),
                TextFieldWidget(
                  controller: controller.dateController,
                  onTap: controller.selectDate,
                  label: 'التاريخ',
                  enabled: false,
                  radius: 20.r,
                  labelColor: const Color(0xFFB0B0B0),
                  hintFontWeight: FontWeight.bold,
                  suffixIcon: Icon(
                    Icons.date_range_outlined,
                    size: 30.w,
                    color: const Color(0xFFB0B0B0),
                  ),
                ),
                TextFieldWidget(
                  controller: controller.imageController,
                  onTap: controller.pickImage,
                  label: 'ارفاق صورة فاتورة',
                  enabled: false,
                  radius: 20.r,
                  labelColor: const Color(0xFFB0B0B0),
                  hintFontWeight: FontWeight.bold,
                  suffixIcon: Container(
                    padding: EdgeInsets.all(15.w),
                    child: SvgPicture.asset('assets/images/select_image.svg'),
                  ),
                ),
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
                ElevatedButton.icon(
                  onPressed: () {
                    Get.back();
                    controller.clearData();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black45,
                    size: 24,
                  ),
                  label: const Text(
                    "إلغاء",
                    style: TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'amarai',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50.h),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: BorderSide(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                5.ph,
              ],
            ).paddingSymmetric(horizontal: 20.w),
          );
        },
      ),
      isDismissible: false,
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }
}
