import 'package:almetlaa/controller/companies_controller.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../widgets/company_widget.dart';
import '../widgets/shimmer/companies_shimmer.dart';

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: GetBuilder<CompaniesController>(
          builder: (controller) {
            return Text(
              controller.category['name'],
              style: TextStyle(fontSize: 20.sp,color: Colors.white),
            );
          },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<CompaniesController>(
        init: CompaniesController(),
        builder: (controller) {
          return controller.loadingCompanies
              ? const CompaniesShimmer()
              : controller.companies.isEmpty
                  ? const Center(
                      child: Text("لا يوجد"),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          38.ph,
                          AlignedGridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 20.w,
                            shrinkWrap: true,
                            itemCount: controller.companies.length,
                            crossAxisCount: 2,
                            itemBuilder: (_, index) {
                              return CompanyWidget(
                                item: controller.companies[index],
                                onTap: () {
                                  Get.toNamed(
                                    Routes.companyProfilePage,
                                    arguments: controller.companies[index],
                                  );
                                },
                              );
                            },
                          ).paddingOnly(left: 20.w, right: 20.w),
                          38.ph,
                        ],
                      ),
                    );
        },
      ),
    );
  }
}
