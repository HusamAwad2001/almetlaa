import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/consultation_controller.dart';
import '../../values/constants.dart';
import '../widgets/text_field_widget.dart';

class ConsultationPage extends StatelessWidget {
  const ConsultationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "طلب استشارة",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: GetBuilder<ConsultationController>(
        init: ConsultationController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "رقم الهاتف",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                20.ph,
                TextFieldWidget(
                  controller: controller.mobileNumberController,
                  textInputType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                  ],
                  label: 'رقم الهاتف',
                  radius: 10.r,
                  labelColor: Colors.grey,
                ),
                30.ph,
                Text(
                  "عنوان الاستشارة",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                20.ph,
                TextFieldWidget(
                  controller: controller.topicController,
                  label: 'عنوان الاستشارة',
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  radius: 10.r,
                  labelColor: Colors.grey,
                ),
                30.ph,
                Text(
                  "وصف الاستشارة",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                20.ph,
                TextFieldWidget(
                  controller: controller.descriptionController,
                  label: 'وصف مختصر عن الاستشارة',
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(200),
                  ],
                  radius: 10.r,
                  labelColor: Colors.grey,
                  maxLines: 4,
                ),
                50.ph,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.submitConsultation,
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
                          ),
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        Constants.primaryColor,
                      ),
                    ),
                    child: const Text(
                      "إرسال الطلب",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ).paddingOnly(top: 20.h, bottom: 20.h),
                  ),
                ),
              ],
            ),
          );
        },
      ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
    );
  }
}
