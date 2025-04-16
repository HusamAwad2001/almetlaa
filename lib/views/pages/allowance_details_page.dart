import '../../controller/allowance_controller.dart';
import '../../values/constants.dart';
import '../../views/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AllowanceDetailsPage extends StatelessWidget {
  const AllowanceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments;

    return GetBuilder<AllowanceController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 280.h,
                backgroundColor: Constants.primaryColor,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 16.w, bottom: 16.h),
                  title: Text(
                    item['title'],
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                  background: Hero(
                    tag: item['image'],
                    child: AppImage(
                      imageUrl: item['image'],
                      width: Get.width,
                      height: 280.h,
                      fit: BoxFit.cover,
                      indicatorColor: Colors.white,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            size: 22.w,
                            color: Colors.grey,
                          ),
                          6.pw,
                          Text(
                            '${item['views']} مشاهدة',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            controller.extractDate(item['createdAt']),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      16.ph,
                      Divider(color: Colors.grey.shade300),
                      16.ph,
                      Text(
                        item['description'],
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF5E5E5E),
                          height: 1.6,
                        ),
                      ),
                      32.ph,
                      // Center(
                      //   child: Column(
                      //     children: [
                      //       Text(
                      //         'للتواصل عبر الهاتف:',
                      //         style: TextStyle(
                      //           fontSize: 14.sp,
                      //           fontWeight: FontWeight.bold,
                      //           color: Constants.primaryColor,
                      //         ),
                      //       ),
                      //       12.ph,
                      //       InkWell(
                      //         onTap: () {
                      //           launchUrl(Uri.parse(
                      //               "tel:${item['user']['phoneNumber']}"));
                      //         },
                      //         borderRadius: BorderRadius.circular(40.r),
                      //         child: Container(
                      //           padding: EdgeInsets.all(12.r),
                      //           decoration: BoxDecoration(
                      //             color:
                      //                 Constants.primaryColor.withOpacity(0.1),
                      //             shape: BoxShape.circle,
                      //           ),
                      //           child: Image.asset(
                      //             'assets/images/call.png',
                      //             width: 50.w,
                      //             height: 50.h,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // 30.ph,
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: InkWell(
            onTap: () {
              launchUrl(Uri.parse("tel:${item['user']['phoneNumber']}"));
            },
            borderRadius: BorderRadius.circular(40.r),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/call.png',
                width: 50.w,
                height: 50.h,
              ),
            ),
          ),
        );
      },
    );
  }
}
