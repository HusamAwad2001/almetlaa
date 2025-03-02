import 'package:almetlaa/core/global.dart';
import 'package:almetlaa/core/storage.dart';
import 'package:almetlaa/routes/routes.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text("حسابي",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          24.ph,
          const Icon(Icons.account_circle,color: Colors.black12,size: 100,),
          24.ph,
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Constants.primaryColor,width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    const Text("رقم الهاتف :",style: TextStyle(color: Colors.black38),),
                    Text(Global.user['phoneNumber'].toString(),style: const TextStyle(color: Constants.primaryColor,fontWeight: FontWeight.bold),)
                  ],).paddingSymmetric(horizontal: 20.w,vertical: 20.h),
                ),
                24.ph,
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Constants.primaryColor,width: 1),
                      borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    const Text("رقم الهاتف :",style: TextStyle(color: Colors.black38),),
                    Text(Global.user['phoneNumber'].toString(),style: const TextStyle(color: Constants.primaryColor,fontWeight: FontWeight.bold),)
                  ],).paddingSymmetric(horizontal: 20.w,vertical: 20.h),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () async{
                Global.token="";
                Global.user={};
                await Storage.instance.erase();
                Get.offAllNamed(Routes.splashPage);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                    side: const BorderSide(color: Color(0xFFF20A34)),
                  ),
                ),
              ),
              child: const Text(
                "مسح الحساب",
                style: TextStyle(color: Color(0xFFF20A34)),
              ).paddingOnly(top: 15.h, bottom: 15.h),
            ),
          ),
          24.ph,
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () async{
                Global.token="";
                Global.user={};
                await Storage.instance.erase();
                Get.offAllNamed(Routes.splashPage);
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                    side: const BorderSide(color: Constants.primaryColor),
                  ),
                ),
              ),
              child: const Text(
                "تسجيل الخروج",
                style: TextStyle(color: Constants.primaryColor),
              ).paddingOnly(top: 15.h, bottom: 15.h),
            ),
          ),
          150.ph,
        ],
      ).paddingAll(20),
    );
  }
}
