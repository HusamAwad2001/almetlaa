import '../../controller/categories_controller.dart';
import '../../views/widgets/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../values/constants.dart';
import '../widgets/shimmer/categories_shimmer.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "التصنيفات",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<CategoriesController>(
        init: CategoriesController(),
        builder: (controller) {
          return controller.loadingCategories
              ? const CategoriesShimmer()
              : controller.categories.isEmpty
                  ? const Center(
                      child: Text("لا يوجد"),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          AlignedGridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 10.w,
                            shrinkWrap: true,
                            itemCount: controller.categories.length,
                            crossAxisCount: 4,
                            itemBuilder: (_, index) {
                              return CategoryWidget(
                                item: controller.categories[index],
                                onTap: () {
                                  Get.toNamed(Routes.companiesPage,
                                      arguments: controller.categories[index]);
                                },
                              );
                            },
                          ).paddingOnly(left: 10.w, right: 10.w),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    );
        },
      ),
    );
  }
}
