import 'package:almetlaa/controller/allowance_controller.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AllowanceDetailsPage extends StatelessWidget {
  const AllowanceDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments;
    return GetBuilder<AllowanceController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Constants.primaryColor,
            title: FittedBox(
              child: Text(item['title'],style: const TextStyle(color: Colors.white),),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/share.png',
                  color: Colors.white,
                  width: 25.w,
                  height: 25.h,
                ),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 27.ph,
              Image.network(
                item['image'],
                width: Get.width,
                height: 415.h,
                // fit: BoxFit.fitHeight,
              ),
              Text(
                item['title'],
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Constants.primaryColor,
                ),
              ),
              22.ph,
              Text(
                item['description'],
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF959595),
                ),
              ),
              30.ph,
              const Divider(color: Color(0xFFAFAFAF)),
              11.ph,
              Row(
                children: [
                  Text(
                    item['views'].toString(),
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF959595),
                    ),
                  ),
                  8.pw,
                  Icon(
                    Icons.remove_red_eye,
                    size: 18.w,
                    color: const Color(0xFF959595),
                  ),
                  const Spacer(),
                  Text(
                    controller.extractDate(item['createdAt']),
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF959595),
                    ),
                  ),
                ],
              ),
              // 100.ph,
              const Spacer(),
              Text(
                'للإتصال:',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  launchUrl(
                    Uri.parse(
                      "tel:${item['user']['phoneNumber']}",
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
          ).paddingSymmetric(horizontal: 20.w),
        );
      },
    );
  }
}
