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
        title: const Text(
          "البدل",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.createExchangePage),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GetBuilder<AllowanceController>(
        init: AllowanceController(),
        builder: (controller) {
          return Column(
            children: [
              Row(
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
        // return const AllowanceShimmer();
        return controller.loadingExchange
            ? const AllowanceShimmer()
            : controller.listAllExchange.isEmpty
                ? const Center(child: Text('لا يوجد'))
                : ListView.separated(
                    itemCount: controller.listAllExchange.length,
                    separatorBuilder: (context, index) => 25.ph,
                    itemBuilder: (context, index) {
                      final item = controller.listAllExchange[index];
                      return InkWell(
                        onTap: () {
                          // controller.getOneExchangeById(item['_id']);
                          Get.toNamed(
                            Routes.allowanceDetailsPage,
                            arguments: item,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                color:
                                    const Color(0xFF585858).withOpacity(0.25),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/transfer.png',
                                width: 60.w,
                                height: 60.h,
                                color: Constants.darkPrimaryColor,
                              ).paddingAll(30.w),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      item['title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        letterSpacing: -0.24,
                                      ),
                                    ),
                                    9.ph,
                                    Text(
                                      item['description'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        letterSpacing: -0.24,
                                        color: const Color(0xFF989898),
                                      ),
                                    ),
                                    6.ph,
                                    Text(
                                      controller.extractDate(item['createdAt']),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        letterSpacing: -0.24,
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
        return controller.loadingExchange
            ? const AllowanceShimmer()
            : controller.listAllExchange.isEmpty
                ? const Center(child: Text('لا يوجد'))
                : AlignedGridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    mainAxisSpacing: 25.h,
                    crossAxisSpacing: 20.w,
                    shrinkWrap: true,
                    itemCount: controller.listAllExchange.length,
                    crossAxisCount: 2,
                    itemBuilder: (_, index) {
                      final item = controller.listAllExchange[index];
                      return InkWell(
                        onTap: () {
                          // controller.getOneExchangeById(item['_id']);
                          Get.toNamed(
                            Routes.allowanceDetailsPage,
                            arguments: item,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 1),
                                color:
                                    const Color(0xFF585858).withOpacity(0.25),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.asset(
                                'assets/images/transfer.png',
                                width: 60.w,
                                height: 60.h,
                                color: Constants.darkPrimaryColor,
                              ).paddingOnly(
                                  top: 16.h,
                                  bottom: 8.h,
                                  right: 55.w,
                                  left: 55.w),
                              Text(
                                item['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  letterSpacing: -0.24,
                                ),
                              ).paddingSymmetric(horizontal: 16.w),
                              6.ph,
                              Text(
                                item['description'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  letterSpacing: -0.24,
                                  color: const Color(0xFF989898),
                                ),
                              ).paddingSymmetric(horizontal: 16.w),
                              8.ph,
                              Text(
                                controller.extractDate(item['createdAt']),
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  letterSpacing: -0.24,
                                  color: const Color(0xFF989898),
                                ),
                              ).paddingOnly(left: 16.w, bottom: 16.h),
                            ],
                          ),
                        ),
                      );
                    },
                  );
      },
    ).paddingSymmetric(horizontal: 20.w);
  }
}
