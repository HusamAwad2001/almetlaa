import '../../controller/login_controller.dart';
import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/text_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextDirection textDirection = TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
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
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                24.ph,
                Image.asset(
                  "assets/images/baiti_logo.png",
                  width: 150,
                  height: 150,
                ),
                24.ph,
                TextFieldWidget(
                  label: "رقم الهاتف",
                  controller: controller.phoneTEC,
                  textInputType: TextInputType.phone,
                  textDirection: textDirection,
                  prefixIcon: const Icon(
                    Icons.phone,
                    size: 25,
                    color: Constants.primaryColor,
                  ),
                  onChange: (value) {
                    if (value.length == 9) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                    if (value.isNotEmpty) {
                      setState(() {
                        textDirection = TextDirection.ltr;
                      });
                    } else {
                      setState(() {
                        textDirection = TextDirection.rtl;
                      });
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                ),
                50.ph,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.validate,
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ).paddingOnly(top: 20.h, bottom: 20.h),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w),
          );
        },
      ),
    );
  }
}
