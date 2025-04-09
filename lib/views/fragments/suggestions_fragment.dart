import 'package:almetlaa/values/constants.dart';
import 'package:almetlaa/views/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/suggestions_controller.dart';

class SuggestionsFragment extends GetView<SuggestionsController> {
  const SuggestionsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Text(
          "اقتراحاتكم",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: GetBuilder<SuggestionsController>(
        init: SuggestionsController(),
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "الموضوع",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.ph,
              TextFieldWidget(
                controller: controller.topicController,
                label: 'الموضوع',
                radius: 10.r,
                labelColor: Colors.grey,
              ),
              30.ph,
              Text(
                "الإقتراح",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.ph,
              TextFieldWidget(
                controller: controller.suggestionController,
                label: 'الإقتراح',
                radius: 10.r,
                labelColor: Colors.grey,
                maxLines: 4,
              ),
              50.ph,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.validate(),
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
                    "إرسال",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ).paddingOnly(top: 20.h, bottom: 20.h),
                ),
              ),
            ],
          );
        },
      ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
    );
  }
}
