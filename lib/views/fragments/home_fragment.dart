import '../../controller/home_controller.dart';
import '../../core/global.dart';
import '../../routes/routes.dart';
import '../../values/constants.dart';
import '../../views/dialogs/call_dialog.dart';
import '../../views/widgets/home_category_widget.dart';
import '../../views/widgets/home_news_widget.dart';
import '../../views/widgets/home_service_widget.dart';
import '../../views/widgets/home_video_widget.dart';
import '../../views/widgets/shimmer/slider_shimmer.dart';
import '../../views/widgets/snack.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFragment extends GetView<HomeController> {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: controller.appbarEnabled
          ? AppBar(
              backgroundColor: Constants.primaryColor,
              toolbarHeight: 50,
              elevation: 1,
              title: Image.asset(
                "assets/images/logo.png",
                height: 45,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    CallDialog().dialog();
                  },
                  icon: const Icon(Icons.call),
                  color: Colors.white,
                ),
                Global.token == ""
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.notificationsPage);
                        },
                        icon: const Icon(Icons.notifications_active),
                        color: Colors.white,
                      ),
              ],
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Constants.primaryColor,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.light,
              ),
            )
          : AppBar(
              backgroundColor: Constants.primaryColor,
              toolbarHeight: 0,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.light,
              ),
            ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        controller: controller.scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.sliderImages.isEmpty
                ? const SliderShimmer()
                : carousel_slider.CarouselSlider(
                    options: carousel_slider.CarouselOptions(
                        height: 350,
                        viewportFraction: 1,
                        autoPlay:
                            controller.sliderImages.length == 1 ? false : true,
                        scrollPhysics: controller.sliderImages.length == 1
                            ? const NeverScrollableScrollPhysics()
                            : const AlwaysScrollableScrollPhysics(),
                        onPageChanged: (i, r) {
                          controller.currentPos = i;
                          controller.update();
                        }),
                    items: controller.sliderImages.map((i) {
                      return Builder(
                        builder: (context) {
                          return InkWell(
                            onTap: () {
                              if (i['url'] != null) {
                                launchUrl(Uri.parse(i['url']));
                              }
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: Image.network(
                                i['image'],
                                height: 350,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.sliderImages
                  .map(
                    (e) => Container(
                      width: 8.w,
                      height: 8.h,
                      margin: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 2.w,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            controller.sliderImages[controller.currentPos] == e
                                ? Constants.primaryColor
                                : const Color(0xFFD9D9D9),
                      ),
                    ),
                  )
                  .toList(),
            ),
            29.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HomeCategoryWidget(
                  image: "assets/images/PAHW-Logo-Icon_1 11.png",
                  title: "الرعاية السكنية",
                  url: "https://www.pahw.gov.kw",
                ),
                10.pw,
                const HomeCategoryWidget(
                  image: "assets/images/PAHW-Logo-Icon_1 12.png",
                  title: "بلدية الكويت",
                  url: "https://www.baladia.gov.kw",
                ),
                10.pw,
                const HomeCategoryWidget(
                  image: "assets/images/PAHW-Logo-Icon_1 13.png",
                  title: "جريدة الانباء",
                  url: "https://www.alanba.com.kw/newspaper/",
                ),
                10.pw,
                const HomeCategoryWidget(
                  image: "assets/images/PAHW-Logo-Icon_1 14.png",
                  title: "اسمنت الكويت",
                  url: "https://www.kcrm-kw.com",
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HomeCategoryWidget(
                  image: "assets/images/PAHW-Logo-Icon_1 15.png",
                  title: "بنك الائتمان",
                  url: "https://www.kcb.gov.kw/",
                ),
                10.pw,
                const HomeCategoryWidget(
                  image: "assets/images/PAHW-Logo-Icon_1 16.png",
                  title: "هويتي",
                  url: "https://hawyti.paci.gov.kw/",
                ),
                10.pw,
                const HomeCategoryWidget(
                  image: "assets/images/PAHW-Logo-Icon_1 17.png",
                  title: "التجارة و الصناعة",
                  url: "https://www.moci.gov.kw/",
                ),
                10.pw,
                const HomeCategoryWidget(
                  image: "assets/images/PAHW-Logo-Icon_1 18.png",
                  title: "الكهرباء و الماء",
                  url: "https://www.mew.gov.kw/",
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w),
            Text(
              "الخدمات",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ).paddingOnly(right: 20.w, top: 36.h, bottom: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeServiceWidget(
                  image: "assets/images/bill3.png",
                  title: "فواتيري",
                  onTap: () {
                    if (Global.token == "") {
                      Snack().show(
                          type: false, message: "الرجاء تسجيل الدخول اولا");
                    } else {
                      Get.toNamed(Routes.constructionBillsPage);
                    }
                  },
                ),
                HomeServiceWidget(
                  image: "assets/images/bill2.png",
                  title: "البدل",
                  onTap: () {
                    if (Global.token == "") {
                      Snack().show(
                          type: false, message: "الرجاء تسجيل الدخول اولا");
                    } else {
                      Get.toNamed(Routes.allowancePage);
                    }
                  },
                ),
                // HomeServiceWidget(
                //   image: "assets/images/bill1.png",
                //   title: "بانوراما",
                //   onTap: () {
                //     Snack().show(type: false, message: "جاري تطوير هذا القسم و سوف يكون متاح قريبا");
                //     return;
                //     if(Global.token==""){
                //       Snack().show(type: false, message: "الرجاء تسجيل الدخول اولا");
                //     }else{
                //       Get.toNamed(Routes.panoramaPage);
                //     }
                //   },
                // ),
                HomeServiceWidget(
                  image: "assets/images/bill.png",
                  title: "الشركات",
                  onTap: () {
                    if (Global.token == "") {
                      Snack().show(
                          type: false, message: "الرجاء تسجيل الدخول اولا");
                    } else {
                      Get.toNamed(Routes.categoriesPage);
                    }
                  },
                ),
                HomeServiceWidget(
                  image: "assets/images/bill4.png",
                  title: "التوزيعات",
                  onTap: () {
                    if (Global.token == "") {
                      Snack().show(
                          type: false, message: "الرجاء تسجيل الدخول اولا");
                    } else {
                      Get.toNamed(Routes.regionsPage);
                    }
                  },
                ),
              ],
            ),
            12.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeServiceWidget(
                  image: "assets/images/bill5.png",
                  title: "الفوائض",
                  onTap: () {
                    if (Global.token == "") {
                      Snack().show(
                          type: false, message: "الرجاء تسجيل الدخول اولا");
                    } else {
                      Get.toNamed(Routes.surplusesPage);
                    }
                  },
                ),
                HomeServiceWidget(
                  image: "assets/images/bill6.png",
                  title: "الأثاث",
                  onTap: () {
                    if (Global.token == "") {
                      Snack().show(
                          type: false, message: "الرجاء تسجيل الدخول اولا");
                    } else {
                      Get.toNamed(Routes.aRPage);
                    }
                  },
                ),
                HomeServiceWidget(
                  image: "assets/images/bill7.png",
                  title: "الفعاليات",
                  onTap: () {
                    if (Global.token == "") {
                      Snack().show(
                          type: false, message: "الرجاء تسجيل الدخول اولا");
                    } else {
                      Get.toNamed(Routes.eventsPage);
                    }
                  },
                ),
                HomeServiceWidget(
                  image: "assets/images/posts.png",
                  title: "الواجهات",
                  onTap: () {
                    if (Global.token == "") {
                      Snack().show(
                          type: false, message: "الرجاء تسجيل الدخول اولا");
                    } else {
                      Get.toNamed(Routes.postPage);
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الأخبار",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ).paddingOnly(right: 20.w, top: 36.h, bottom: 10.h),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.newsPage);
                  },
                  child: Text(
                    "المزيد",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF999797),
                    ),
                  ),
                ).paddingOnly(top: 36.h, bottom: 10.h),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.news
                    .map((e) => InkWell(
                          onTap: () {
                            Get.toNamed(Routes.newsDetailsPage, arguments: e);
                          },
                          child: HomeNewsWidget(item: e),
                        ))
                    .toList(),
              ).paddingOnly(left: 10, right: 10, bottom: 5.h),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الفيديو",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ).paddingOnly(
                  right: 20.w,
                  top: 18.h,
                  bottom: 10.h,
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.videosPage);
                  },
                  child: Text(
                    "المزيد",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF999797),
                    ),
                  ),
                ).paddingOnly(
                  top: 18.h,
                  bottom: 10.h,
                ),
              ],
            ),
            AlignedGridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              shrinkWrap: true,
              itemCount: controller.videos.length,
              crossAxisCount: 2,
              itemBuilder: (_, index) {
                return HomeVideoWidget(
                  item: controller.videos[index],
                  fullWidth: false,
                  onTap: () {
                    Get.toNamed(
                      Routes.videoDetailsPage,
                      arguments: [controller.videos[index], controller.videos],
                    );
                  },
                );
              },
            ).paddingOnly(left: 20, right: 20),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
