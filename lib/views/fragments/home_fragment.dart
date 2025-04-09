import 'package:shimmer/shimmer.dart';

import '../../controller/home_controller.dart';
import '../../core/global.dart';
import '../../routes/routes.dart';
import '../../values/constants.dart';
import '../../views/dialogs/call_dialog.dart';
import '../../views/widgets/home_news_widget.dart';
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

import '../widgets/app_image.dart';

class HomeFragment extends GetView<HomeController> {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: const _AppBarWidget(),
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            controller: controller.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.ph,
                const _SliderWidget(),
                30.ph,
                const _ServicesWidget(),
                22.ph,
                const _NewsWidget(),
                22.ph,
                // const _VideosWidget(),
                // 20.ph,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AppBarWidget extends StatelessWidget {
  const _AppBarWidget();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Constants.primaryColor,
      elevation: 4,
      leadingWidth: 0,
      title: Row(
        children: [
          Image.asset(
            "assets/images/baiti_logo.png",
            height: 40,
          ),
          const SizedBox(width: 8),
          Text(
            'بيتي',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {
            CallDialog().dialog();
          },
          icon: const Icon(Icons.call_outlined),
          tooltip: 'اتصل بنا',
          color: Colors.white,
        ),
        if (Global.token != "")
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.notificationsPage);
            },
            icon: const Icon(Icons.notifications_active_outlined),
            tooltip: 'الإشعارات',
            color: Colors.white,
          ),
        const SizedBox(width: 8),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Constants.primaryColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
}

class _SliderWidget extends StatelessWidget {
  const _SliderWidget();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.sliderImages.isEmpty
            ? const SliderShimmer()
            : Column(
                children: [
                  carousel_slider.CarouselSlider(
                    options: carousel_slider.CarouselOptions(
                      height: 220.h,
                      // viewportFraction: 0.92,
                      autoPlay: controller.sliderImages.length > 1,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: controller.sliderImages.length > 1,
                      scrollPhysics: controller.sliderImages.length == 1
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      onPageChanged: (index, reason) {
                        controller.currentPos = index;
                        controller.update();
                      },
                    ),
                    items: controller.sliderImages.map((i) {
                      return GestureDetector(
                        onTap: () {
                          if (i['url'] != null) {
                            launchUrl(Uri.parse(i['url']));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AppImage(
                                  imageUrl: i['image'],
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.5),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  if (controller.sliderImages.length > 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.sliderImages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          height: 8,
                          width: controller.currentPos == index ? 20 : 8,
                          decoration: BoxDecoration(
                            color: controller.currentPos == index
                                ? Constants.primaryColor
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                ],
              );
      },
    );
  }
}

class _ServicesWidget extends StatelessWidget {
  const _ServicesWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الخدمات",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ).paddingOnly(right: 20.w, bottom: 10.h),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                childAspectRatio: 0.85,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _ServiceItem(
                    icon: Icons.receipt_long_outlined,
                    title: "فواتيري",
                    route: Routes.constructionBillsPage,
                  ),
                  _ServiceItem(
                    icon: Icons.swap_horiz_outlined,
                    title: "البدل",
                    route: Routes.allowancePage,
                  ),
                  _ServiceItem(
                    icon: Icons.business_outlined,
                    title: "الشركات",
                    route: Routes.categoriesPage,
                  ),
                  _ServiceItem(
                    icon: Icons.location_city_outlined,
                    title: "التوزيعات",
                    route: Routes.regionsPage,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                childAspectRatio: 0.85,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _ServiceItem(
                    icon: Icons.attach_money_outlined,
                    title: "الفوائض",
                    route: Routes.surplusesPage,
                  ),
                  _ServiceItem(
                    icon: Icons.chair_outlined,
                    title: "الأثاث",
                    route: Routes.aRPage,
                  ),
                  _ServiceItem(
                    icon: Icons.event_outlined,
                    title: "الفعاليات",
                    route: Routes.eventsPage,
                  ),
                  _ServiceItem(
                    icon: Icons.article_outlined,
                    title: "الواجهات",
                    route: Routes.postPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  const _ServiceItem({
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (Global.token == "") {
            Snack().show(type: false, message: "الرجاء تسجيل الدخول اولا");
          } else {
            Get.toNamed(route);
          }
        },
        splashColor: Constants.primaryColor.withValues(alpha: 0.2),
        highlightColor: Constants.primaryColor.withValues(alpha: 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Constants.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Constants.primaryColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                icon,
                size: 26,
                color: Constants.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsWidget extends GetView<HomeController> {
  const _NewsWidget();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        if (controller.loadingNews) {
          return const _NewsShimmer();
        }
        if (controller.news.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "الأخبار",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      backgroundColor: const Color(0xFFF5F5F5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.newsPage);
                    },
                    child: Text(
                      "المزيد",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.news.length,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  final news = controller.news[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(
                      Routes.newsDetailsPage,
                      arguments: news,
                    ),
                    child: HomeNewsWidget(item: news),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NewsShimmer extends StatelessWidget {
  const _NewsShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 100.w,
              height: 20.h,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: 4,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ignore: unused_element
class _VideosWidget extends StatelessWidget {
  const _VideosWidget();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.loadingVideos
            ? const _VideosShimmer()
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "الفيديو",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     Get.toNamed(Routes.videosPage);
                        //   },
                        //   child: Text(
                        //     "المزيد",
                        //     style: TextStyle(
                        //       fontSize: 12.sp,
                        //       color: const Color(0xFF999797),
                        //     ),
                        //   ),
                        // ).paddingOnly(
                        //   top: 18.h,
                        //   bottom: 10.h,
                        // ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            backgroundColor: const Color(0xFFF5F5F5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.videosPage);
                          },
                          child: Text(
                            "المزيد",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            arguments: [
                              controller.videos[index],
                              controller.videos
                            ],
                          );
                        },
                      );
                    },
                  ).paddingOnly(left: 20, right: 20),
                ],
              );
      },
    );
  }
}

class _VideosShimmer extends StatelessWidget {
  const _VideosShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 100.w,
              height: 20.h,
              color: Colors.white,
            ),
          ),
        ),
        AlignedGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          shrinkWrap: true,
          itemCount: 4,
          crossAxisCount: 2,
          itemBuilder: (_, __) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 160.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
