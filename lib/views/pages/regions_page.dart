import 'package:almetlaa/routes/routes.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/regions_controller.dart';

class RegionsPage extends StatelessWidget {
  const RegionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text("المناطق",style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder(
        init: RegionsController(),
        builder: (controller) {
          return Column(
            children: [
              30.ph,
              TextField(
                onSubmitted: (v) {
                  if (v.isEmpty) {
                    controller.getAllRegions();
                  } else {
                    controller.searchRegions(v);
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
                    borderSide: const BorderSide(width: 1, color: Color(0xFFF0F0F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.r),
                    borderSide: const BorderSide(width: 1, color: Color(0xFFF0F0F0)),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                ),
              ),
              30.ph,
              controller.loadingRegions
                  ? const Expanded(child: Center(child: CircularProgressIndicator()))
                  : controller.listAllRegions.isEmpty
                      ? const Expanded(child: Center(child: Text('لا يوجد مناطق')))
                      : Expanded(
                          child: controller.loadingRegions
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
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
                                        color: Constants.primaryColor,
                                        child: Row(
                                          children: [
                                            20.pw,
                                            SvgPicture.asset(
                                              'assets/images/location.svg',
                                              width: 20.w,
                                              color: Colors.white,
                                            ),
                                            10.pw,
                                            Text(
                                              'المناطق',
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: _RegionListView(controller),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
              30.ph,
            ],
          ).paddingSymmetric(horizontal: 26.w);
        },
      ),
    );
  }
}

class _RegionListView extends StatelessWidget {
  final RegionsController controller;
  const _RegionListView(this.controller);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.listAllRegions.length,
      itemBuilder: (context, index) {
        final item = controller.listAllRegions[index];
        return Column(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(
                  Routes.blocksPage,
                  arguments: item['_id'],
                );
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text(
                  item['name'] ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF292D32),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20.w,
                )
              ],).paddingAll(15),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFE9E9E9),
            ),
          ],
        );
      },
    );
  }
}
