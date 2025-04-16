import '../../controller/surpluses_controller.dart';
import '../../values/constants.dart';
import '../../views/widgets/surpluse_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../widgets/shimmer/surpluses_shimmer.dart';

class SurplusesPage extends GetView<SurplusesController> {
  const SurplusesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "الفوائض",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle, size: 24.w),
            onPressed: () => Get.toNamed(Routes.createSurplusesPage),
          ),
        ],
      ),
      body: GetBuilder<SurplusesController>(
        init: SurplusesController(),
        builder: (_) {
          return Column(
            children: [
              TextField(
                onSubmitted: (v) {
                  if (v.isEmpty) {
                    controller.getAllSurpluses();
                  } else {
                    controller.searchSurpluses(v);
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
              ).paddingOnly(
                right: 31.w,
                left: 31.w,
                top: 30.h,
              ),
              controller.loadingSurpluses
                  ? const Expanded(child: SurplusesShimmer())
                  : Expanded(
                      child: GetBuilder<SurplusesController>(
                        builder: (_) {
                          return controller.listSurpluses.isEmpty
                              ? const Center(child: Text('لا يوجد بيانات'))
                              : ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 31.w, vertical: 24.h),
                                  itemCount: controller.listSurpluses.length,
                                  separatorBuilder: (context, index) => 15.ph,
                                  itemBuilder: (context, index) {
                                    controller.listSurpluses.reversed;
                                    final item =
                                        controller.listSurpluses[index];
                                    return SurplusItemWidget(
                                        item: item, controller: controller);
                                  },
                                );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
