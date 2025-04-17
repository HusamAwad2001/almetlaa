import '../../controller/surpluses_controller.dart';
import '../../values/constants.dart';
import '../../views/widgets/surpluse_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../widgets/app_error_widget.dart';
import '../widgets/shimmer/surpluses_shimmer.dart';

class SurplusesPage extends StatefulWidget {
  const SurplusesPage({super.key});

  @override
  State<SurplusesPage> createState() => _SurplusesPageState();
}

class _SurplusesPageState extends State<SurplusesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          GetBuilder<SurplusesController>(
            builder: (controller) {
              return Visibility(
                visible: controller.errorModel == null &&
                    !controller.loadingSurpluses,
                child: IconButton(
                  icon: Icon(Icons.add_circle, size: 24.w),
                  onPressed: () => Get.toNamed(Routes.createSurplusesPage),
                ),
              );
            },
          ),
        ],
      ),
      body: GetBuilder<SurplusesController>(
        init: SurplusesController(),
        builder: (controller) {
          final ScrollController scrollController = ScrollController();

          scrollController.addListener(() {
            if (scrollController.position.pixels >=
                    scrollController.position.maxScrollExtent - 100 &&
                controller.hasMore &&
                !controller.loadingSurpluses) {
              controller.getAllSurpluses();
            }
          });

          if (controller.loadingSurpluses && controller.surpluses.isEmpty) {
            return const SurplusesShimmer();
          }

          if (controller.errorModel != null && controller.surpluses.isEmpty) {
            return AppErrorWidget(
              errorMessage: controller.errorModel?.message ?? "حدث خطأ ما",
              onRetry: () => controller.getAllSurpluses(),
            );
          }

          if (controller.surpluses.isEmpty) {
            return Center(
              child: Text(
                "لا توجد فوائض",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.getAllSurpluses(isRefresh: true),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: TextField(
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
                  ).paddingOnly(right: 31.w, left: 31.w, top: 30.h),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: 40.h,
                    right: 22.w,
                    left: 22.w,
                    bottom: 80.h,
                  ),
                  sliver: SliverList.separated(
                    addRepaintBoundaries: true,
                    itemCount: controller.surpluses.length +
                        (controller.hasMore ? 1 : 0),
                    separatorBuilder: (context, index) => 15.ph,
                    itemBuilder: (context, index) {
                      print('build: $index');
                      if (index == controller.surpluses.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      final item = controller.surpluses[index];
                      return SurplusItemWidget(item: item);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
