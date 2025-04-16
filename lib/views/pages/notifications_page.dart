import '../../values/constants.dart';
import '../../views/widgets/shimmer/notifications_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/notifications_controller.dart';
import '../widgets/app_error_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "الإشعارات",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        actions: [
          GetBuilder<NotificationsController>(
            builder: (controller) {
              return controller.loadingNotifications ||
                      controller.notifications.isEmpty
                  ? const SizedBox()
                  : TextButton(
                      child: Text(
                        'مسح الكل',
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                      onPressed: () {
                        controller.deleteAll();
                      },
                    );
            },
          )
        ],
      ),
      body: GetBuilder<NotificationsController>(
        init: NotificationsController(),
        builder: (controller) {
          return Builder(
            builder: (context) {
              if (controller.loadingNotifications &&
                  controller.notifications.isEmpty) {
                return const NotificationsShimmer();
              }

              if (controller.errorModel != null &&
                  controller.notifications.isEmpty) {
                return Center(
                  child: AppErrorWidget(
                    errorMessage:
                        controller.errorModel?.message ?? "حدث خطأ ما",
                    onRetry: () =>
                        controller.getAllNotifications(isRefresh: true),
                  ),
                );
              }

              if (controller.notifications.isEmpty) {
                return Center(
                  child: Text(
                    'لا يوجد إشعارات',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }

              final scrollController = ScrollController();
              scrollController.addListener(() {
                if (scrollController.position.pixels >=
                    scrollController.position.maxScrollExtent - 100) {
                  controller.getAllNotifications();
                }
              });

              return RefreshIndicator(
                onRefresh: () => controller.getAllNotifications(),
                child: ListView.separated(
                  controller: scrollController,
                  padding: EdgeInsets.only(
                    top: 40.h,
                    right: 22.w,
                    left: 22.w,
                    bottom: 80.h,
                  ),
                  itemCount: controller.notifications.length +
                      (controller.hasMore ? 1 : 0),
                  separatorBuilder: (context, index) => 15.ph,
                  itemBuilder: (context, index) {
                    if (index == controller.notifications.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final item = controller.notifications[index];
                    return NotificationItem(item: item, index: index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationItem extends GetView<NotificationsController> {
  final Map<String, dynamic> item;
  final int index;
  const NotificationItem({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'], style: TextStyle(fontSize: 14.sp)),
                5.ph,
                Text(
                  item['message'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade700,
                    height: 1.8,
                  ),
                ),
                5.ph,
                Text(
                  item['createdAt'].toString().substring(0, 10),
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          10.pw,
          GestureDetector(
            onTap: () => controller.deleteNotification(
              item['_id'],
              index,
            ),
            child: Icon(Icons.close, color: Colors.grey, size: 20.w),
          ),
        ],
      ).paddingAll(15),
    );
  }
}
