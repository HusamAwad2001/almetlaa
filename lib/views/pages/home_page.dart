import 'package:almetlaa/controller/home_controller.dart';
import 'package:almetlaa/core/global.dart';
import 'package:almetlaa/routes/routes.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:almetlaa/views/dialogs/call_dialog.dart';
import 'package:almetlaa/views/fragments/profile_fragment.dart';
import 'package:almetlaa/views/fragments/questions_fragment.dart';
import 'package:almetlaa/views/fragments/suggestions_fragment.dart';
import 'package:almetlaa/views/widgets/home_category_widget.dart';
import 'package:almetlaa/views/widgets/home_news_widget.dart';
import 'package:almetlaa/views/widgets/home_service_widget.dart';
import 'package:almetlaa/views/widgets/home_video_widget.dart';
import 'package:almetlaa/views/widgets/shimmer/slider_shimmer.dart';
import 'package:almetlaa/views/widgets/snack.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../fragments/mes_voisins_fragment.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              controller.selectedPage == 1
                  ? const SuggestionsFragment()
                  : controller.selectedPage == 2
                      ? const MesVoisinsFragment()
                      : controller.selectedPage == 3
                          ? const QuestionsFragment()
                          : controller.selectedPage == 4
                              ? const ProfileFragment()
                              : Scaffold(
                                  appBar: controller.appbarEnabled
                                      ? AppBar(
                                          backgroundColor:
                                              Constants.primaryColor,
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
                                                      Get.toNamed(Routes
                                                          .notificationsPage);
                                                    },
                                                    icon: const Icon(Icons
                                                        .notifications_active),
                                                    color: Colors.white,
                                                  ),
                                          ],
                                          systemOverlayStyle:
                                              const SystemUiOverlayStyle(
                                            statusBarColor:
                                                Constants.primaryColor,
                                            statusBarBrightness:
                                                Brightness.dark,
                                            statusBarIconBrightness:
                                                Brightness.light,
                                          ),
                                        )
                                      : AppBar(
                                          backgroundColor:
                                              Constants.primaryColor,
                                          toolbarHeight: 0,
                                          elevation: 0,
                                          systemOverlayStyle:
                                              const SystemUiOverlayStyle(
                                            statusBarColor: Colors.transparent,
                                            statusBarBrightness:
                                                Brightness.dark,
                                            statusBarIconBrightness:
                                                Brightness.light,
                                          ),
                                        ),
                                  body: SingleChildScrollView(
                                    physics: const ClampingScrollPhysics(),
                                    controller: controller.scrollController,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        controller.sliderImages.isEmpty
                                            ? const SliderShimmer()
                                            : carousel_slider.CarouselSlider(
                                                options: carousel_slider
                                                    .CarouselOptions(
                                                        height: 350,
                                                        viewportFraction: 1,
                                                        autoPlay: controller
                                                                    .sliderImages
                                                                    .length ==
                                                                1
                                                            ? false
                                                            : true,
                                                        scrollPhysics: controller
                                                                    .sliderImages
                                                                    .length ==
                                                                1
                                                            ? const NeverScrollableScrollPhysics()
                                                            : const AlwaysScrollableScrollPhysics(),
                                                        onPageChanged: (i, r) {
                                                          controller
                                                              .currentPos = i;
                                                          controller.update();
                                                        }),
                                                items: controller.sliderImages
                                                    .map((i) {
                                                  return Builder(
                                                    builder: (context) {
                                                      return InkWell(
                                                        onTap: () {
                                                          if (i['url'] !=
                                                              null) {
                                                            launchUrl(Uri.parse(
                                                                i['url']));
                                                          }
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                          child: Image.network(
                                                            i['image'],
                                                            height: 350,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }).toList(),
                                              ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                    color: controller
                                                                    .sliderImages[
                                                                controller
                                                                    .currentPos] ==
                                                            e
                                                        ? Constants.primaryColor
                                                        : const Color(
                                                            0xFFD9D9D9),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                        29.ph,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const HomeCategoryWidget(
                                              image:
                                                  "assets/images/PAHW-Logo-Icon_1 11.png",
                                              title: "الرعاية السكنية",
                                              url: "https://www.pahw.gov.kw",
                                            ),
                                            10.pw,
                                            const HomeCategoryWidget(
                                              image:
                                                  "assets/images/PAHW-Logo-Icon_1 12.png",
                                              title: "بلدية الكويت",
                                              url: "https://www.baladia.gov.kw",
                                            ),
                                            10.pw,
                                            const HomeCategoryWidget(
                                              image:
                                                  "assets/images/PAHW-Logo-Icon_1 13.png",
                                              title: "جريدة الانباء",
                                              url:
                                                  "https://www.alanba.com.kw/newspaper/",
                                            ),
                                            10.pw,
                                            const HomeCategoryWidget(
                                              image:
                                                  "assets/images/PAHW-Logo-Icon_1 14.png",
                                              title: "اسمنت الكويت",
                                              url: "https://www.kcrm-kw.com",
                                            ),
                                          ],
                                        ).paddingSymmetric(horizontal: 20.w),
                                        20.ph,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const HomeCategoryWidget(
                                              image:
                                                  "assets/images/PAHW-Logo-Icon_1 15.png",
                                              title: "بنك الائتمان",
                                              url: "https://www.kcb.gov.kw/",
                                            ),
                                            10.pw,
                                            const HomeCategoryWidget(
                                              image:
                                                  "assets/images/PAHW-Logo-Icon_1 16.png",
                                              title: "هويتي",
                                              url:
                                                  "https://hawyti.paci.gov.kw/",
                                            ),
                                            10.pw,
                                            const HomeCategoryWidget(
                                              image:
                                                  "assets/images/PAHW-Logo-Icon_1 17.png",
                                              title: "التجارة و الصناعة",
                                              url: "https://www.moci.gov.kw/",
                                            ),
                                            10.pw,
                                            const HomeCategoryWidget(
                                              image:
                                                  "assets/images/PAHW-Logo-Icon_1 18.png",
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
                                        ).paddingOnly(
                                            right: 20.w,
                                            top: 36.h,
                                            bottom: 25.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            HomeServiceWidget(
                                              image: "assets/images/bill3.png",
                                              title: "فواتيري",
                                              onTap: () {
                                                if (Global.token == "") {
                                                  Snack().show(
                                                      type: false,
                                                      message:
                                                          "الرجاء تسجيل الدخول اولا");
                                                } else {
                                                  Get.toNamed(Routes
                                                      .constructionBillsPage);
                                                }
                                              },
                                            ),
                                            HomeServiceWidget(
                                              image: "assets/images/bill2.png",
                                              title: "البدل",
                                              onTap: () {
                                                if (Global.token == "") {
                                                  Snack().show(
                                                      type: false,
                                                      message:
                                                          "الرجاء تسجيل الدخول اولا");
                                                } else {
                                                  Get.toNamed(
                                                      Routes.allowancePage);
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
                                                      type: false,
                                                      message:
                                                          "الرجاء تسجيل الدخول اولا");
                                                } else {
                                                  Get.toNamed(
                                                      Routes.categoriesPage);
                                                }
                                              },
                                            ),
                                            HomeServiceWidget(
                                              image: "assets/images/bill4.png",
                                              title: "التوزيعات",
                                              onTap: () {
                                                if (Global.token == "") {
                                                  Snack().show(
                                                      type: false,
                                                      message:
                                                          "الرجاء تسجيل الدخول اولا");
                                                } else {
                                                  Get.toNamed(
                                                      Routes.regionsPage);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        12.ph,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            HomeServiceWidget(
                                              image: "assets/images/bill5.png",
                                              title: "الفوائض",
                                              onTap: () {
                                                if (Global.token == "") {
                                                  Snack().show(
                                                      type: false,
                                                      message:
                                                          "الرجاء تسجيل الدخول اولا");
                                                } else {
                                                  Get.toNamed(
                                                      Routes.surplusesPage);
                                                }
                                              },
                                            ),
                                            HomeServiceWidget(
                                              image: "assets/images/bill6.png",
                                              title: "الأثاث",
                                              onTap: () {
                                                if (Global.token == "") {
                                                  Snack().show(
                                                      type: false,
                                                      message:
                                                          "الرجاء تسجيل الدخول اولا");
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
                                                      type: false,
                                                      message:
                                                          "الرجاء تسجيل الدخول اولا");
                                                } else {
                                                  Get.toNamed(
                                                      Routes.eventsPage);
                                                }
                                              },
                                            ),
                                            HomeServiceWidget(
                                              image: "assets/images/posts.png",
                                              title: "الواجهات",
                                              onTap: () {
                                                if (Global.token == "") {
                                                  Snack().show(
                                                      type: false,
                                                      message:
                                                          "الرجاء تسجيل الدخول اولا");
                                                } else {
                                                  Get.toNamed(Routes.postPage);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "الأخبار",
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.start,
                                            ).paddingOnly(
                                                right: 20.w,
                                                top: 36.h,
                                                bottom: 10.h),
                                            TextButton(
                                              onPressed: () {
                                                Get.toNamed(Routes.newsPage);
                                              },
                                              child: Text(
                                                "المزيد",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color:
                                                      const Color(0xFF999797),
                                                ),
                                              ),
                                            ).paddingOnly(
                                                top: 36.h, bottom: 10.h),
                                          ],
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: controller.news
                                                .map((e) => InkWell(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            Routes
                                                                .newsDetailsPage,
                                                            arguments: e);
                                                      },
                                                      child: HomeNewsWidget(
                                                          item: e),
                                                    ))
                                                .toList(),
                                          ).paddingOnly(
                                              left: 10, right: 10, bottom: 5.h),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                  color:
                                                      const Color(0xFF999797),
                                                ),
                                              ),
                                            ).paddingOnly(
                                              top: 18.h,
                                              bottom: 10.h,
                                            ),
                                          ],
                                        ),
                                        AlignedGridView.count(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
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
                                                  arguments: [
                                                    controller.videos[index],
                                                    controller.videos
                                                  ],
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
                                ),
              Container(
                margin: EdgeInsets.all(25.w),
                decoration: BoxDecoration(
                  color: Constants.darkPrimaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        if (controller.selectedPage != 1) {
                          if (Global.token != "") {
                            controller.selectedPage = 1;
                            controller.update();
                          } else {
                            Snack().show(
                                type: false,
                                message: "الرجاء تسجيل الدخول اولا");
                          }
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.health_and_safety,
                            color: Colors.white,
                          ),
                          7.ph,
                          Text(
                            "اقتراحاتي",
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //Get.toNamed(Routes.mesVoisinsPage);
                        if (controller.selectedPage != 2) {
                          controller.selectedPage = 2;
                          controller.update();
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/home (3) 5.png",
                            width: 22.w,
                            height: 22.w,
                          ),
                          7.ph,
                          Text(
                            "جيراني",
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(),
                    const SizedBox(),
                    InkWell(
                      onTap: () {
                        //Get.toNamed(Routes.questionsPage);
                        if (controller.selectedPage != 3) {
                          controller.selectedPage = 3;
                          controller.update();
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/home (3) 2.png",
                            width: 18.w,
                            height: 18.h,
                          ),
                          7.ph,
                          Text(
                            "الاسئلة",
                            style:
                                TextStyle(color: Colors.white, fontSize: 11.sp),
                          )
                        ],
                      ),
                    ),
                    Global.token == ""
                        ? InkWell(
                            onTap: () {
                              Get.toNamed(Routes.loginPage);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                                7.pw,
                                Text(
                                  "دخول",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11.sp),
                                )
                              ],
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              //Get.toNamed(Routes.profilePage);
                              if (controller.selectedPage != 4) {
                                controller.selectedPage = 4;
                                controller.update();
                              }
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/images/home (3) 4.png",
                                  width: 18.w,
                                  height: 18.h,
                                ),
                                7.ph,
                                Text(
                                  "حسابي",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11.sp),
                                )
                              ],
                            ),
                          ),
                  ],
                ).paddingOnly(top: 15.h, bottom: 15.h),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 55.h),
                padding: EdgeInsets.all(10.w),
                width: 200.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(0.25),
                      spreadRadius: 4,
                      blurRadius: 21,
                      offset: const Offset(-1, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    if (controller.selectedPage != 0) {
                      controller.selectedPage = 0;
                      controller.update();
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/home.png",
                        width: 20,
                        height: 20,
                      ),
                      Text(
                        "الرئيسية",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
