import '../../controller/videos_controller.dart';
import '../../values/constants.dart';
import '../../views/widgets/app_image.dart';
import '../../views/widgets/shimmer/videos_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../routes/routes.dart';

class VideosPage extends GetView<VideosController> {
  const VideosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "الفيديو",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            30.ph,
            TextField(
              onSubmitted: (v) {
                if (v.isEmpty) {
                  controller.getVideos();
                } else {
                  controller.searchVideos(v);
                }
              },
              decoration: InputDecoration(
                hintText: 'البحث',
                prefixIcon: Container(
                  width: 22.w,
                  height: 22.h,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/search.png',
                    width: 22.w,
                    height: 22.h,
                    color: Constants.primaryColor,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9.r),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFFF0F0F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9.r),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFFF0F0F0)),
                ),
                filled: true,
                fillColor: const Color(0xFFF5F5F5),
              ),
            ),
            30.ph,
            GetBuilder<VideosController>(
              init: VideosController(),
              builder: (controller) {
                return controller.loadingVideos
                    ? const VideosShimmer()
                    : controller.videos.isEmpty
                        ? const Text("لا يوجد بيانات")
                            .paddingOnly(top: Get.height / 3.5)
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.videos.length,
                            separatorBuilder: (_, __) => 29.ph,
                            itemBuilder: (_, index) {
                              final item = controller.videos[index];
                              return InkWell(
                                onTap: () {
                                  //VideoDialog().dialog(item);
                                  Get.toNamed(
                                    Routes.videoDetailsPage,
                                    arguments: [
                                      controller.videos[index],
                                      controller.videos
                                    ],
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.r)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(bottom: 5.h),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        height: 207.h,
                                        width: double.infinity,
                                        child: AppImage(
                                          imageUrl: item['image'],
                                          fit: BoxFit.cover,
                                          height: 207.h,
                                          width: double.infinity,
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: double.infinity,
                                            height: 70.h,
                                            alignment: Alignment.bottomRight,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(20.r),
                                                bottomRight:
                                                    Radius.circular(20.r),
                                              ),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black,
                                                ],
                                                stops: [0.0, 1.0],
                                                begin:
                                                    FractionalOffset.topCenter,
                                                end: FractionalOffset
                                                    .bottomCenter,
                                                tileMode: TileMode.repeated,
                                              ),
                                            ),
                                            child: Text(
                                              item['title'],
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ).paddingOnly(
                                              bottom: 18.h,
                                              right: 15.h,
                                              left: 15.w,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
              },
            ).paddingOnly(left: 22.w, right: 22.w),
            20.ph,
          ],
        ),
      ),
    );
  }
}
