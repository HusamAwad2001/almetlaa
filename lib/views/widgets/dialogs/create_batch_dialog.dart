import 'package:almetlaa/values/constants.dart';
import 'package:almetlaa/views/widgets/text_field_widget.dart';
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
                  label: 'نوع الدفعة',
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
                ),
                InkWell(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    controller.selectDate();
                  },
                  child: TextFieldWidget(
                    controller: controller.dateController,
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
                ),
                InkWell(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    controller.pickImage();
                  },
                  child: TextFieldWidget(
                    controller: controller.imageController,
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
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.validate();
                  },
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      const Color(0xFF01367C),
                    ),
                  ),
                  child: Text(
                    "انشاء",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ).paddingSymmetric(vertical: 20.h, horizontal: 15.w),
                ),
                5.ph,
              ],
            ).paddingSymmetric(horizontal: 20.w),
          );
        },
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }
}
