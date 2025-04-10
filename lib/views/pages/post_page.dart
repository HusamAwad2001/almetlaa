import 'package:flutter_svg/flutter_svg.dart';

import '../../controller/post_controller.dart';
import '../../values/constants.dart';
import '../../views/widgets/app_image.dart';
import '../../views/widgets/shimmer/posts_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/text_field_widget.dart';

class PostPage extends GetView<PostController> {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "الواجهات",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        actions: [
          GetBuilder<PostController>(
            builder: (_) {
              return controller.type == "-createdAt"
                  ? IconButton(
                      onPressed: () {
                        if (!controller.loadingPosts) {
                          controller.type = "-countLikes";
                          controller.loadingPosts = true;
                          controller.update();
                          controller.getPosts(controller.type);
                        }
                      },
                      icon: Image.asset(
                        "assets/images/trending.png",
                        width: 25,
                        height: 25,
                      ))
                  : IconButton(
                      onPressed: () {
                        if (!controller.loadingPosts) {
                          controller.type = "-createdAt";
                          controller.loadingPosts = true;
                          controller.update();
                          controller.getPosts(controller.type);
                        }
                      },
                      icon: Image.asset(
                        "assets/images/trend.png",
                        width: 25,
                        height: 25,
                      ));
            },
          )
        ],
      ),
      body: GetBuilder<PostController>(
        init: PostController(),
        builder: (controller) {
          return controller.loadingPosts
              ? const PostsShimmer()
              : ListView.separated(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, top: 20.h, bottom: 150.h),
                  itemCount: controller.posts.length,
                  separatorBuilder: (_, __) => 29.ph,
                  itemBuilder: (_, index) {
                    return Container(
                      key: UniqueKey(),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF000000).withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                              () => Scaffold(
                                    body: Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Center(
                                          child: Hero(
                                            tag: Get.arguments,
                                            child: AppImage(
                                              imageUrl: Get.arguments,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 28.w,
                                          top: 59.w,
                                          child: InkWell(
                                            onTap: () => Get.back(),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Container(
                                              padding: EdgeInsets.all(10.w),
                                              decoration: const BoxDecoration(
                                                color: Color(0xff646464),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              arguments: controller.posts[index]['image'],
                              transition: Transition.fade);
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Column(
                            children: [
                              Hero(
                                tag: controller.posts[index]['image'],
                                child: AppImage(
                                  imageUrl: controller.posts[index]['image'],
                                  width: double.infinity,
                                  height: 190.h,
                                ),
                              ),
                              Row(
                                children: [
                                  controller.posts[index]['createdBy']
                                              ['image'] ==
                                          null
                                      ? CircleAvatar(
                                          radius: 20.r,
                                          backgroundColor: Colors.black12,
                                          child: const Icon(
                                            Icons.perm_identity,
                                            color: Colors.white,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 20.r,
                                          backgroundImage: NetworkImage(
                                              controller.posts[index]
                                                  ['createdBy']['image']),
                                        ),
                                  10.pw,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          controller.posts[index]['createdBy']
                                              ['name'],
                                          style: TextStyle(fontSize: 14.sp)),
                                      5.ph,
                                      Text(
                                          controller.posts[index]['createdAt']
                                              .split("T")[0],
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          controller.posts[index]['countLikes']
                                              .toString(),
                                          style: TextStyle(fontSize: 16.sp)),
                                      5.pw,
                                      controller.posts[index]['isLiked']
                                          ? IconButton(
                                              onPressed: () {
                                                controller.like(
                                                    controller.posts[index]
                                                        ['_id'],
                                                    index,
                                                    false);
                                              },
                                              icon: const Icon(
                                                Icons.favorite,
                                                color: Color(0xFFe74c3c),
                                              ),
                                              constraints:
                                                  const BoxConstraints(),
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                controller.like(
                                                    controller.posts[index]
                                                        ['_id'],
                                                    index,
                                                    true);
                                              },
                                              icon: const Icon(
                                                  Icons.favorite_border),
                                              constraints:
                                                  const BoxConstraints(),
                                            ),
                                    ],
                                  ),
                                ],
                              ).paddingAll(10),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.imageController.clear();
          controller.imageFile?.delete();
          // Get.bottomSheet(
          //   SafeArea(
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         InkWell(
          //           onTap: () {
          //             FocusManager.instance.primaryFocus?.unfocus();
          //             controller.pickImage();
          //           },
          //           child: TextFieldWidget(
          //             controller: controller.imageController,
          //             label: 'صورة الواجهة',
          //             enabled: false,
          //             radius: 10.r,
          //             labelColor: const Color(0xFFB0B0B0),
          //             hintFontWeight: FontWeight.bold,
          //             suffixIcon: Container(
          //               padding: EdgeInsets.all(15.w),
          //               child:
          //                   SvgPicture.asset('assets/images/select_image.svg'),
          //             ),
          //           ),
          //         ),
          //         const SizedBox(
          //           height: 20,
          //         ),
          //         20.ph,
          //         FloatingActionButton(
          //           onPressed: () => controller.post(),
          //           backgroundColor: Constants.primaryColor,
          //           child: const Icon(Icons.add, color: Colors.white),
          //         ),
          //       ],
          //     ).paddingAll(20.w),
          //   ),
          //   isScrollControlled: true,
          //   backgroundColor: Colors.white,
          // );
          Get.bottomSheet(
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          controller.pickImage();
                        },
                        child: TextFieldWidget(
                          controller: controller.imageController,
                          label: 'صورة الواجهة',
                          enabled: false,
                          radius: 10.r,
                          labelColor: const Color(0xFFB0B0B0),
                          hintFontWeight: FontWeight.bold,
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(15.w),
                            child: SvgPicture.asset(
                              'assets/images/select_image.svg',
                            ),
                          ),
                        ),
                      ),
                      25.ph,
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: FloatingActionButton(
                      //     onPressed: controller.post,
                      //     backgroundColor: Constants.primaryColor,
                      //     child: const Icon(Icons.add, color: Colors.white),
                      //   ),
                      // ),
                      ElevatedButton.icon(
                        onPressed: controller.post,
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24,
                        ),
                        label: const Text(
                          "إضافة",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'amarai',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50.h),
                          backgroundColor: Constants.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isScrollControlled: true,
            backgroundColor: Colors.white,
          );
        },
        backgroundColor: Constants.primaryColor,
        child: const Icon(
          Icons.add_photo_alternate_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
