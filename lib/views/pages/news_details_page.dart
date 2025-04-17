import 'package:baiti/views/pages/blocks_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../views/widgets/app_image.dart';
import '../../controller/news_details_controller.dart';
import '../../values/constants.dart';

class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<NewsDetailsController>(
        init: NewsDetailsController(),
        builder: (controller) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Constants.primaryColor,
                expandedHeight: 300.h,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    final isCollapsed = constraints.biggest.height <=
                        kToolbarHeight + MediaQuery.of(context).padding.top;
                    return FlexibleSpaceBar(
                      centerTitle: false,
                      title: isCollapsed
                          ? Text(
                              controller.item['title'],
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
                              imageUrl: controller.item['image'],
                              heroTag: controller.item['_id'],
                            )),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Hero(
                              tag: controller.item['_id'],
                              child: AppImage(
                                imageUrl: controller.item['image'],
                                fit: BoxFit.cover,
                                indicatorColor: Colors.white,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black26, Colors.transparent],
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
              ),
              SliverToBoxAdapter(
                child: AnimatedOpacity(
                  opacity: 1,
                  duration: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.ph,
                        Text(
                          controller.item['title'],
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        25.ph,
                        Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/playstore.png',
                                width: 55.w,
                                height: 55.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                            10.pw,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '2:00 PM',
                                  style: TextStyle(
                                      fontSize: 13.sp, color: Colors.grey[600]),
                                ),
                                Text(
                                  '20-2-2023',
                                  style: TextStyle(
                                      fontSize: 13.sp, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              controller.item['views'].toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey[600]),
                            ),
                            6.pw,
                            const Icon(
                              Icons.remove_red_eye,
                              size: 20,
                              color: Color(0xFF9A9A9A),
                            ),
                          ],
                        ),
                        20.ph,
                        const Divider(thickness: 1, color: Color(0xFFC7C7C7)),
                        20.ph,
                        Text(
                          controller.item['description'].toString().trim(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color(0xFF5A5A5A),
                            fontWeight: FontWeight.w400,
                            height: 1.6.h,
                          ),
                        ),
                        40.ph,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
