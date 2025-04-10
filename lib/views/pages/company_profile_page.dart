import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyProfilePage extends StatelessWidget {
  const CompanyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: Get.width,
            height: 210.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  Get.arguments['images'][1],
                ),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomLeft,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: -60.h,
                  left: 30.w,
                  child: Container(
                    width: 137.w,
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Constants.darkPrimaryColor,
                          Constants.primaryColor,
                        ],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(Get.arguments['logo']),
                    ),
                  ),
                ),
                Positioned(
                  top: 64.h,
                  left: 36.w,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: const Color(0xFFA9A9A9),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 20.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          25.ph,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              Get.arguments['name'],
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Constants.primaryColor,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(right: 40.w),
          ),
          10.ph,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              Get.arguments['description'],
              textAlign: TextAlign.start,
              style: TextStyle(
                color: const Color(0xFF747474),
                fontSize: 9.sp,
              ),
            ).paddingOnly(right: 40.w),
          ),
          36.ph,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'الأعمال السابقة',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(right: 20.w),
          ),
          11.ph,
          SizedBox(
            height: 180.h,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              scrollDirection: Axis.horizontal,
              itemCount: Get.arguments['images'].length,
              separatorBuilder: (context, index) => 10.pw,
              itemBuilder: (context, index) {
                return Container(
                  height: 180.h,
                  width: 160.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF696969).withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      )
                    ],
                    image: DecorationImage(
                      image: NetworkImage(Get.arguments['images'][index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const SizedBox(),
                );
              },
            ),
          ),
          // 60.ph,
          // ListTile(
          //   contentPadding: EdgeInsets.symmetric(horizontal: 26.w),
          //   title: Text(
          //     '23شارع أحمد الجابر , العاصمة',
          //     textAlign: TextAlign.start,
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 13.sp,
          //     ),
          //   ),
          //   subtitle: Text(
          //     'افتح على الخرائط',
          //     textAlign: TextAlign.start,
          //     style: TextStyle(
          //       color: const Color(0xFF9D9D9D),
          //       fontSize: 13.sp,
          //     ),
          //   ),
          //   trailing: Image.asset('assets/images/map.png', width: 49.w),
          // ),
          // Divider(
          //   height: 0,
          //   color: const Color(0xFFE7E7E7),
          //   thickness: 1,
          //   endIndent: 26.w,
          //   indent: 26.w,
          // ),
          45.ph,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'للإتصال:',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(right: 20.w),
          ),
          20.ph,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              Get.arguments['phoneNumber'],
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(right: 20.w),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              launchUrl(
                Uri.parse(
                  "tel:${Get.arguments['phoneNumber']}",
                ),
              );
            },
            child: Image.asset(
              'assets/images/call.png',
              width: 60.w,
              height: 60.h,
            ),
          ),
          30.ph,
        ],
      ),
    );
  }
}
