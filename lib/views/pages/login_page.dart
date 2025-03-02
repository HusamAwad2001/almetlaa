import 'package:almetlaa/controller/login_controller.dart';
import 'package:almetlaa/routes/routes.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/text_field_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "تسجيل الدخول",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<LoginController>(
            init: LoginController(),
            builder: ((controller) => Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Constants.primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFFD9D9D9),
                                offset: Offset(0, 0),
                                spreadRadius: 3,
                                blurRadius: 3)
                          ]),
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 150,
                        height: 150,
                      ).paddingOnly(bottom: 40),
                    ),
                    24.ph,
                    TextFieldWidget(
                      label: "رقم الهاتف",
                      controller: controller.phoneTEC,
                      textInputType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                    24.ph,
                    TextFieldWidget(
                      label: "كلمة المرور",
                      controller: controller.passTEC,
                      textInputType: TextInputType.text,
                      isPassword: true,
                    ),
                    12.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "نسيت كلمة المرور ؟",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF999797),
                            ),
                          ),
                        ),
                      ],
                    ),
                    12.ph,
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.validate();
                        },
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                            Constants.primaryColor,
                          ),
                        ),
                        child: const Text(
                          "الدخول",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ).paddingOnly(top: 20.h, bottom: 20.h),
                      ),
                    ),
                    56.ph,
                    const Text(
                      "ليس لديك حساب ؟",
                      style: TextStyle(fontSize: 12, color: Color(0xFF999797)),
                    ),
                    20.ph,
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.registerPage);
                        },
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                side:
                                    BorderSide(color: Constants.primaryColor)),
                          ),
                        ),
                        child: const Text(
                          "حساب جديد",
                          style: TextStyle(
                              color: Constants.primaryColor, fontSize: 16),
                        ).paddingOnly(top: 10.h, bottom: 10.h),
                      ),
                    ),
                    20.ph,
                  ],
                )),
          ).paddingOnly(left: 20, right: 20),
        ),
      ),
    );
  }
}
