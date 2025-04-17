import '../../controller/events_controller.dart';
import '../../values/constants.dart';
import '../../views/widgets/app_image.dart';
import '../../views/widgets/shimmer/videos_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/app_error_widget.dart';
import 'blocks_page.dart';

class EventsPage extends GetView<EventsController> {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "الفعاليات",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: GetBuilder<EventsController>(
        init: EventsController(),
        builder: (context) {
          final ScrollController scrollController = ScrollController();

          scrollController.addListener(() {
            if (scrollController.position.pixels >=
                    scrollController.position.maxScrollExtent - 100 &&
                controller.hasMore &&
                !controller.loadingEvents) {
              controller.getEvents();
            }
          });

          if (controller.loadingEvents && controller.events.isEmpty) {
            return const VideosShimmer().paddingAll(20.w);
          }

          if (controller.errorModel != null && controller.events.isEmpty) {
            return AppErrorWidget(
              errorMessage: controller.errorModel?.message ?? "حدث خطأ ما",
              onRetry: controller.getEvents,
            );
          }

          if (controller.events.isEmpty) {
            return Center(
              child: Text(
                "لا توجد فعاليات",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.getEvents(
              isRefresh: true,
            ),
            child: ListView.separated(
              padding: EdgeInsets.all(20.w),
              controller: scrollController,
              itemCount:
                  controller.events.length + (controller.hasMore ? 1 : 0),
              separatorBuilder: (context, index) => 15.ph,
              itemBuilder: (context, index) {
                if (index == controller.events.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final item = controller.events[index];
                return EventItem(item: item);
              },
            ),
          );
        },
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final Map item;
  const EventItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Get.to(
                  () => FullImagePage(imageUrl: item['image']),
                ),
                child: Hero(
                  tag: item['image'],
                  child: AppImage(
                    imageUrl: item['image'],
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300]!,
            ),
            Text(
              item['name'],
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ).paddingAll(10)
          ],
        ),
      ),
    );
  }
}
