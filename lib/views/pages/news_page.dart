import 'package:almetlaa/controller/news_controller.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:almetlaa/views/widgets/shimmer/news_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../routes/routes.dart';

class NewsPage extends GetView<NewsController> {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text("الاخبار",style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            30.ph,
            TextField(
              onSubmitted: (v){
                if(v.isEmpty){
                  controller.getNews();
                }else{
                  controller.searchNews(v);
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
            30.ph,
            GetBuilder<NewsController>(
              init: NewsController(),
              builder: (controller) {
                return controller.loadingNews? const NewsShimmer() : controller.news.isEmpty? const Text("لا يوجد بيانات").paddingOnly(top: Get.height/3.5) : AlignedGridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    mainAxisSpacing: 25.h,
                    crossAxisSpacing: 25.w,
                    shrinkWrap: true,
                    itemCount: controller.news.length,
                    crossAxisCount: 2,
                    itemBuilder: (_, index) {
                      final item = controller.news[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.newsDetailsPage, arguments: item);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20.r)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000).withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: const Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  topRight: Radius.circular(20.r),
                                ),
                                child: Image.network(
                                  item['image'],
                                  width: double.infinity,
                                  height: 117.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              7.ph,
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  item['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ).paddingOnly(left: 6.w, right: 10.w),
                              ),
                              5.ph,
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  item['description'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xFF999797),
                                  ),
                                ).paddingOnly(left: 6.w, right: 10.w),
                              ),
                              10.ph,
                            ],
                          ),
                        ),
                      );
                      // return HomeNewsWidget(item: controller.news[index]);
                    },
                );
              },
            ),
            20.ph,
          ],
        ).paddingSymmetric(horizontal: 25.w),
      ),
    );
  }
}
