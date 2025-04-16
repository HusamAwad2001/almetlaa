import 'package:almetlaa/views/widgets/app_error_widget.dart';

import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../controller/allowance_controller.dart';
import '../../routes/routes.dart';
import '../widgets/shimmer/allowance_shimmer.dart';

class AllowancePage extends StatelessWidget {
  const AllowancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Text("البدل"),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.createExchangePage),
            icon: Icon(Icons.add_circle, size: 24.w),
          ),
        ],
      ),
      body: GetBuilder<AllowanceController>(
        init: AllowanceController(),
        builder: (controller) {
          return Column(
            children: [
              Visibility(
                visible: !(controller.errorModel != null &&
                    controller.listAllExchange.isEmpty),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onSubmitted: (v) {
                          if (v.isEmpty) {
                            controller.getAllExchange();
                          } else {
                            controller.searchExchange(v);
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
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xFFF0F0F0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.r),
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xFFF0F0F0)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                    32.pw,
                    InkWell(
                      onTap: () => controller.switchGridStyle(),
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        width: 45.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: const Color(0xFFF0F0F0),
                            width: 2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/${controller.isGrid ? 'list' : 'grid'}.png',
                          width: 25.w,
                          height: 25.h,
                          color: Constants.darkPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(
                  right: 31.w,
                  left: 21.w,
                  top: 30.h,
                ),
              ),
              31.ph,
              Expanded(
                child: controller.isGrid
                    ? const GridViewItem()
                    : const ListViewItem(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllowanceController>(
      builder: (controller) {
        return controller.loadingExchange && controller.listAllExchange.isEmpty
            ? const AllowanceShimmer()
            : controller.errorModel != null &&
                    controller.listAllExchange.isEmpty
                ? AppErrorWidget(
                    errorMessage:
                        controller.errorModel?.message ?? "حدث خطأ ما",
                    onRetry: () => controller.getAllExchange(),
                  )
                : controller.listAllExchange.isEmpty
                    ? const Center(
                        child: Text(
                          'لا يوجد',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView.separated(
                        controller: controller.scrollController,
                        itemCount: controller.listAllExchange.length +
                            (controller.hasMoreExchange ? 1 : 0),
                        separatorBuilder: (context, index) => 25.ph,
                        itemBuilder: (context, index) {
                          if (index == controller.listAllExchange.length) {
                            return const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final item = controller.listAllExchange[index];
                          return ExchangeItem(
                            data: item,
                            isGrid: false,
                            onTap: () => Get.toNamed(
                              Routes.allowanceDetailsPage,
                              arguments: item,
                            ),
                          );
                        },
                      );
      },
    ).paddingSymmetric(horizontal: 20.w);
  }
}

class GridViewItem extends StatelessWidget {
  const GridViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllowanceController>(
      builder: (controller) {
        return controller.loadingExchange && controller.listAllExchange.isEmpty
            ? const AllowanceShimmer()
            : controller.listAllExchange.isEmpty
                ? const Center(
                    child: Text(
                      'لا يوجد',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        AlignedGridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 20),
                          mainAxisSpacing: 25.h,
                          crossAxisSpacing: 25.w,
                          shrinkWrap: true,
                          itemCount: controller.listAllExchange.length,
                          crossAxisCount: 2,
                          itemBuilder: (_, index) {
                            final item = controller.listAllExchange[index];
                            return ExchangeItem(
                              data: item,
                              isGrid: true,
                              onTap: () => Get.toNamed(
                                Routes.allowanceDetailsPage,
                                arguments: item,
                              ),
                            );
                          },
                        ),
                        if (controller.hasMoreExchange &&
                            controller.listAllExchange.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  );
      },
    ).paddingSymmetric(horizontal: 20.w);
  }
}

class ExchangeItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  final bool isGrid;

  const ExchangeItem({
    super.key,
    required this.data,
    required this.onTap,
    required this.isGrid,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: const Color(0xFFF0F0F0),
            width: 2,
          ),
        ),
        padding: EdgeInsets.all(isGrid ? 0 : 20.w),
        child: isGrid
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/images/transfer.png',
                    width: 60.w,
                    height: 60.h,
                    color: Constants.darkPrimaryColor,
                  ).paddingOnly(
                      top: 16.h, bottom: 8.h, right: 55.w, left: 55.w),
                  Text(
                    data['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.sp),
                  ).paddingSymmetric(horizontal: 16.w),
                  6.ph,
                  Text(
                    data['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF989898),
                    ),
                  ).paddingSymmetric(horizontal: 16.w),
                  8.ph,
                  Text(
                    data['createdAt'], // عادي غيرها بـ extractDate
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF989898),
                    ),
                  ).paddingOnly(left: 16.w, bottom: 16.h),
                ],
              )
            : Row(
                children: [
                  Image.asset(
                    'assets/images/transfer.png',
                    width: 60.w,
                    height: 60.h,
                    color: Constants.darkPrimaryColor,
                  ).paddingAll(10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        9.ph,
                        Text(
                          data['description'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF989898),
                          ),
                        ),
                        6.ph,
                        Text(
                          data['createdAt'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF989898),
                          ),
                        ),
                      ],
                    ).paddingOnly(left: 20.w),
                  ),
                ],
              ),
      ),
    );
  }
}
