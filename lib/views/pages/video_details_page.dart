import 'package:almetlaa/views/widgets/app_image.dart';

import '../../controller/home_controller.dart';
import '../../controller/video_details_controller.dart';
import '../../values/constants.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../widgets/home_video_widget.dart';

class VideoDetailsPage extends GetView<HomeController> {
  const VideoDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "الفيديو",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: GetBuilder<VideoDetailsController>(
        init: VideoDetailsController(),
        builder: (controller) {
          return Column(
            children: [
              BetterPlayer.network(
                controller.item['video'],
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  placeholder: AppImage(imageUrl: controller.item['image']),
                  autoPlay: false,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  controller.item['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ).paddingOnly(right: 19.w, top: 30.h),
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
              ).paddingSymmetric(horizontal: 20.w, vertical: 15.h),
              const Divider(
                height: 0,
                thickness: 1,
                color: Color(0xFFC7C7C7),
              ).paddingSymmetric(horizontal: 20.w, vertical: 15.h),
              Expanded(
                child: AlignedGridView.count(
                  padding: EdgeInsets.zero,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  shrinkWrap: true,
                  itemCount: controller.videos.length,
                  crossAxisCount: 2,
                  itemBuilder: (_, index) {
                    return HomeVideoWidget(
                      item: controller.videos[index],
                      fullWidth: false,
                      onTap: () {},
                    );
                  },
                ).paddingOnly(left: 20, right: 20),
              ),
            ],
          );
        },
      ),
    );
  }
}
