import 'package:almetlaa/controller/register_controller.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/text_field_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text("حساب جديد",style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios).paddingOnly(right: 30.w),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<RegisterController>(
          init: RegisterController(),
          builder: (controller) {
            return Column(
              children: [
                48.ph,
                TextFieldWidget(
                  label: "الاسم",
                  controller: controller.nameTEC,
                  textInputType: TextInputType.text,
                ),
                24.ph,
                TextFieldWidget(
                  label: "رقم الهاتف",
                  textInputType: TextInputType.phone,
                  controller: controller.phoneTEC,
                ),
                24.ph,
                TextFieldWidget(
                  label: "كلمة المرور",
                  controller: controller.pass1TEC,
                  textInputType: TextInputType.text,
                  isPassword: true,
                ),
                24.ph,
                TextFieldWidget(
                  label: "تأكيد كلمة المرور",
                  controller: controller.pass2TEC,
                  textInputType: TextInputType.text,
                  isPassword: true,
                ),
                50.ph,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.validate(),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Constants.primaryColor,
                      ),
                    ),
                    child: const Text(
                      "تسجيل",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ).paddingOnly(top: 20.h, bottom: 20.h),
                  ),
                ),
                5.ph,
              ],
            );
          },
        ).paddingOnly(left: 20, right: 20),
      ),
    );
  }
}
