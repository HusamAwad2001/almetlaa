import 'package:baiti/views/pages/blocks_page.dart';

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
              Builder(
                builder: (context) {
                  return SliverAppBar(
                    backgroundColor: Constants.primaryColor,
                    expandedHeight: 300.h,
                    pinned: true,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        bool isCollapsed = constraints.biggest.height <=
                            kToolbarHeight + MediaQuery.of(context).padding.top;
                        return FlexibleSpaceBar(
                          centerTitle: false,
                          title: isCollapsed
                              ? Text(
                                  item['title'],
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ).paddingOnly(left: 10.w)
                              : null,
                          background: GestureDetector(
                            onTap: () => Get.to(() => FullImagePage(
                                  imageUrl: item['image'],
                                  heroTag: item['_id'],
                                )),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Hero(
                                  tag: item['_id'],
                                  child: AppImage(
                                    imageUrl: item['image'],
                                    fit: BoxFit.cover,
                                    indicatorColor: Colors.white,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black26,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              // SliverAppBar(
              //   pinned: true,
              //   expandedHeight: 280.h,
              //   backgroundColor: Constants.primaryColor,
              //   flexibleSpace: FlexibleSpaceBar(
              //     titlePadding: EdgeInsets.only(left: 16.w, bottom: 16.h),
              //     title: Text(
              //       item['title'],
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis,
              //       style:
              //           Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              //                 fontSize: 14.sp,
              //               ),
              //     ).paddingOnly(right: 56.w),
              //     background: Hero(
              //       tag: item['image'],
              //       child: AppImage(
              //         imageUrl: item['image'],
              //         width: Get.width,
              //         height: 280.h,
              //         fit: BoxFit.cover,
              //         indicatorColor: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      20.ph,
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
                color: Constants.primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/call.png',
                width: 50.w,
                height: 50.h,
                color: Constants.primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
