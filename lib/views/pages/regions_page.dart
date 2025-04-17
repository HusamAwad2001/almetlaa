import '../../routes/routes.dart';
import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/regions_controller.dart';
import '../widgets/app_error_widget.dart';

class RegionsPage extends StatelessWidget {
  const RegionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text("التوزيعات"),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<RegionsController>(
        init: RegionsController(),
        builder: (controller) {
          if (controller.loadingRegions && controller.listAllRegions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorModel != null &&
              controller.listAllRegions.isEmpty) {
            return AppErrorWidget(
              errorMessage: controller.errorModel?.message ?? "حدث خطأ ما",
              onRetry: () => controller.getAllRegions(),
            );
          }

          if (controller.listAllRegions.isEmpty) {
            return Center(
              child: Text(
                'لا يوجد توزيعات',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                width: 1,
                color: const Color(0xFFE9E9E9),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                    ),
                  ),
                  child: Row(
                    children: [
                      20.pw,
                      SvgPicture.asset(
                        'assets/images/location.svg',
                        width: 22.w,
                        color: Colors.white,
                      ),
                      10.pw,
                      Text(
                        'المناطق',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification.metrics.pixels >=
                              scrollNotification.metrics.maxScrollExtent -
                                  100 &&
                          !controller.loadingRegions &&
                          controller.hasMore) {
                        controller.getAllRegions();
                      }
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: controller.listAllRegions.length + 1,
                      itemBuilder: (context, index) {
                        if (index < controller.listAllRegions.length) {
                          final item = controller.listAllRegions[index];
                          return RegionItem(region: item);
                        } else {
                          return controller.hasMore
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                )
                              : const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ).paddingAll(26.w);
        },
      ),
    );
  }
}

class RegionItem extends StatelessWidget {
  final Map<String, dynamic> region;
  const RegionItem({super.key, required this.region});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Get.toNamed(
            Routes.blocksPage,
            arguments: region['_id'],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                region['name'] ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 18.sp),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20.w,
              )
            ],
          ).paddingAll(15),
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: Color(0xFFE9E9E9),
        ),
      ],
    );
  }
}
