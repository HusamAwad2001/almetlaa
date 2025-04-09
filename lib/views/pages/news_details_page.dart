import 'package:almetlaa/controller/news_details_controller.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<NewsDetailsController>(
        init: NewsDetailsController(),
        builder: (controller) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 317.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      controller.item['image'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 28.w, top: 59.w),
                    padding: EdgeInsets.all(10.w),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  controller.item['title'],
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ).paddingOnly(top: 30.h, bottom: 60.h, right: 20.w, left: 20.w),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.remove_red_eye,
                    color: Color(0xFF808080),
                  ),
                  10.pw,
                  Text(
                    controller.item['views'].toString(),
                  ),
                  const Spacer(),
                  Text(
                    '   2:00 PM\n20-2-2023',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xFF808080),
                    ),
                  ),
                  SizedBox(width: 11.w),
                  Container(
                    width: 50.w,
                    height: 50.h,
                    padding: EdgeInsets.all(5.w),
                    decoration: const BoxDecoration(
                      color: Constants.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/baiti_logo.png',
                    ).paddingOnly(bottom: 5.h),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20.w),
              const Divider(
                thickness: 1,
                color: Color(0xFFC7C7C7),
              ).paddingSymmetric(horizontal: 20.w),
              20.ph,
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    controller.item['description'],
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: const Color(0xFF727070),
                      fontWeight: FontWeight.w300,
                      height: 1.6.h,
                    ),
                  ),
                ).paddingSymmetric(horizontal: 20.w),
              ),
            ],
          );
        },
      ),
    );
  }
}
