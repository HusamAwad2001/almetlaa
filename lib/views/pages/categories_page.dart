import '../../controller/categories_controller.dart';
import '../../views/widgets/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../values/constants.dart';
import '../widgets/app_error_widget.dart';
import '../widgets/shimmer/categories_shimmer.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "الشركات",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<CategoriesController>(
        init: CategoriesController(),
        builder: (controller) {
          scrollController.addListener(() {
            if (scrollController.position.pixels >=
                    scrollController.position.maxScrollExtent - 100 &&
                controller.hasMore &&
                !controller.loadingCategories) {
              controller.getCategories();
            }
          });

          if (controller.loadingCategories && controller.categories.isEmpty) {
            return const CategoriesShimmer();
          }

          if (controller.errorModel != null && controller.categories.isEmpty) {
            return AppErrorWidget(
              errorMessage: controller.errorModel?.message ?? "حدث خطأ ما",
              onRetry: controller.getCategories,
            );
          }

          if (controller.categories.isEmpty) {
            return Center(
              child: Text(
                "لا توجد شركات",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                AlignedGridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: 16.h,
                    left: 16.w,
                    right: 16.w,
                  ),
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  shrinkWrap: true,
                  itemCount: controller.categories.length,
                  crossAxisCount: 3,
                  itemBuilder: (_, index) {
                    return CategoryWidget(
                      item: controller.categories[index],
                      onTap: () {
                        Get.toNamed(
                          Routes.companiesPage,
                          arguments: controller.categories[index],
                        );
                      },
                    );
                  },
                ),
                if (controller.loadingCategories)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: const CircularProgressIndicator(),
                  )
                else
                  50.ph,
              ],
            ),
          );
        },
      ),
    );
  }
}
