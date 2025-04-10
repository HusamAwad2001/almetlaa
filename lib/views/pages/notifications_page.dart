import '../../values/constants.dart';
import '../../views/widgets/shimmer/notifications_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/notifications_controller.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

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
          return controller.loadingNotifications
              ? const NotificationsShimmer()
              : controller.notifications.isEmpty
                  ? const Center(child: Text('لا يوجد إشعارات'))
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 15.w),
                      itemCount: controller.notifications.length,
                      separatorBuilder: (context, index) => 10.ph,
                      itemBuilder: (context, index) {
                        final item = controller.notifications[index];
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
                                    Text(item['title'],
                                        style: TextStyle(fontSize: 14.sp)),
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
                                      item['createdAt']
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                          fontSize: 10.sp, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              10.pw,
                              GestureDetector(
                                onTap: () => controller.deleteNotification(
                                    item['_id'], index),
                                child: Icon(Icons.close,
                                    color: Colors.grey, size: 20.w),
                              ),
                            ],
                          ).paddingAll(15),
                        );
                      },
                    );
        },
      ),
    );
  }
}
