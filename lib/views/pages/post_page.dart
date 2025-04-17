import 'package:baiti/views/pages/blocks_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controller/post_controller.dart';
import '../../values/constants.dart';
import '../../views/widgets/app_image.dart';
import '../../views/widgets/shimmer/posts_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/app_error_widget.dart';
import '../widgets/text_field_widget.dart';

class PostPage extends GetView<PostController> {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text("الواجهات"),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<PostController>(
        init: PostController(),
        builder: (controller) {
          final ScrollController scrollController = ScrollController();

          scrollController.addListener(() {
            if (scrollController.position.pixels >=
                    scrollController.position.maxScrollExtent - 100 &&
                controller.hasMore &&
                !controller.loadingPosts) {
              controller.getPosts();
            }
          });

          if (controller.loadingPosts && controller.posts.isEmpty) {
            return const PostsShimmer();
          }

          if (controller.errorModel != null && controller.posts.isEmpty) {
            return AppErrorWidget(
              errorMessage: controller.errorModel?.message ?? "حدث خطأ ما",
              onRetry: () => controller.getPosts(),
            );
          }

          if (controller.posts.isEmpty) {
            return Center(
              child: Text(
                "لا توجد واجهات",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.getPosts(
              isRefresh: true,
            ),
            child: ListView.separated(
              controller: scrollController,
              padding: EdgeInsets.only(
                top: 40.h,
                right: 22.w,
                left: 22.w,
                bottom: 80.h,
              ),
              itemCount: controller.posts.length + (controller.hasMore ? 1 : 0),
              separatorBuilder: (context, index) => 15.ph,
              itemBuilder: (context, index) {
                if (index == controller.posts.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final item = controller.posts[index];
                return EventItem(item: item, index: index);
              },
            ),
          );
        },
      ),
      floatingActionButton: GetBuilder<PostController>(
        builder: (controller) {
          return Visibility(
            visible: controller.errorModel == null && !controller.loadingPosts,
            child: FloatingActionButton(
              onPressed: () {
                controller.imageController.clear();
                controller.imageFile?.delete();
                Get.bottomSheet(
                  SafeArea(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 25.h),
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
        },
      ),
    );
  }
}

class EventItem extends GetView<PostController> {
  final Map<String, dynamic> item;
  final int index;
  const EventItem({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(
          width: 2,
          color: Colors.grey[300]!,
        ),
      ),
      child: GestureDetector(
        onTap: () => Get.to(
          () => FullImagePage(imageUrl: item['image']),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Column(
            children: [
              Hero(
                tag: item['image'],
                child: AppImage(
                  imageUrl: item['image'],
                  width: double.infinity,
                  height: 190.h,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.black12,
                    child: const Icon(
                      Icons.perm_identity,
                      color: Colors.white,
                    ),
                  ),
                  10.pw,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['createdBy']['phoneNumber'],
                          style: TextStyle(fontSize: 14.sp)),
                      5.ph,
                      Text(
                        item['createdAt'].split("T")[0],
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(item['countLikes'].toString(),
                          style: TextStyle(fontSize: 16.sp)),
                      item['isLiked']
                          ? IconButton(
                              onPressed: () {
                                controller.like(
                                  item['_id'],
                                  index,
                                  false,
                                );
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Color(0xFFe74c3c),
                              ),
                              constraints: const BoxConstraints(),
                            )
                          : IconButton(
                              onPressed: () {
                                controller.like(item['_id'], index, true);
                              },
                              icon: const Icon(Icons.favorite_border),
                              constraints: const BoxConstraints(),
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
  }
}
