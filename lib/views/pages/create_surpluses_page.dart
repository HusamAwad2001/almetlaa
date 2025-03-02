import 'package:almetlaa/controller/surpluses_controller.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../widgets/text_field_widget.dart';

class CreateSurplusesPage extends StatelessWidget {
  const CreateSurplusesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text('إضافة فوائض'),
        centerTitle: true,
        elevation: 0,
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
              ),
              15.ph,
              TextFieldWidget(
                controller: controller.priceController,
                label: 'السعر',
                textInputType: TextInputType.number,
                radius: 10.r,
                labelColor: const Color(0xFFB0B0B0),
                hintFontWeight: FontWeight.bold,
              ),
              15.ph,
              TextFieldWidget(
                controller: controller.biddingPeriodController,
                label: 'عدد أيام المزايدة',
                textInputType: TextInputType.number,
                radius: 10.r,
                labelColor: const Color(0xFFB0B0B0),
                hintFontWeight: FontWeight.bold,
              ),
              15.ph,
              InkWell(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  controller.pickImage();
                },
                child: TextFieldWidget(
                  controller: controller.imageController,
                  label: 'ارفاق صورة',
                  enabled: false,
                  radius: 10.r,
                  labelColor: const Color(0xFFB0B0B0),
                  hintFontWeight: FontWeight.bold,
                  suffixIcon: Container(
                    padding: EdgeInsets.all(15.w),
                    child: SvgPicture.asset('assets/images/select_image.svg'),
                  ),
                ),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () => controller.validate(),
                backgroundColor: Constants.primaryColor,
                child: const Icon(Icons.add),
              ),
            ],
          );
        },
      ).paddingSymmetric(vertical: 50.h, horizontal: 30.w),
    );
  }
}
