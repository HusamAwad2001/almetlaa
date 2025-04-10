import '../../core/global.dart';
import '../../core/storage.dart';
import '../../routes/routes.dart';
import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final String phone = Global.user['phoneNumber'].toString();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Text(
          "حسابي",
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
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            24.ph,
            const CircleAvatar(
              backgroundColor: Colors.black12,
              radius: 50,
              backgroundImage: AssetImage("assets/images/baiti_logo.png"),
            ),
            16.ph,
            Text(
              "أهلاً بك 👋",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            32.ph,
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
                side: BorderSide(
                  color: Constants.primaryColor.withOpacity(0.5),
                  width: 1,
                ),
              ),
              color: Colors.transparent,
              elevation: 0,
              // shadowColor: Constants.primaryColor.withOpacity(0.2),
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Constants.primaryColor.withOpacity(0.1),
                      child: const Icon(Icons.phone_android,
                          color: Constants.primaryColor),
                    ),
                    16.pw,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "رقم الهاتف",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15.sp,
                            ),
                          ),
                          4.ph,
                          Text(
                            phone,
                            style: TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    // Global.token = "";
                    // Global.user = {};
                    // await Storage.instance.erase();
                    Get.offAllNamed(Routes.loginPage);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 24,
                  ),
                  label: const Text(
                    "تسجيل الخروج",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'amarai',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    textStyle:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
                24.ph,
                Text(
                  "⚠️ حذف الحساب يؤدي إلى مسح جميع بياناتك ولا يمكن التراجع",
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                12.ph,
                OutlinedButton.icon(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("تأكيد الحذف"),
                        content: const Text("هل أنت متأكد من حذف الحساب؟"),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(result: false),
                            child: const Text("إلغاء"),
                          ),
                          TextButton(
                            onPressed: () => Get.back(result: true),
                            child: const Text(
                              "احذف الحساب",
                              style: TextStyle(color: Color(0xFFF20A34)),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      Global.token = "";
                      Global.user = {};
                      await Storage.instance.erase();
                      Get.offAllNamed(Routes.splashPage);
                    }
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Constants.primaryColor,
                    size: 24,
                  ),
                  label: const Text(
                    "حذف الحساب",
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'amarai',
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    // foregroundColor: const Color(0xFFF20A34),
                    foregroundColor:
                        Constants.primaryColor.withValues(alpha: 0.2),
                    side: const BorderSide(
                      color: Constants.primaryColor,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    textStyle: TextStyle(fontSize: 14.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
