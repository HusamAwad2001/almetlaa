import 'dart:developer';

import 'package:almetlaa/core/global.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/surpluses_details_controller.dart';
import '../widgets/shimmer/offers_shimmer.dart';
import '../widgets/text_field_widget.dart';

class SurplusesDetailsPage extends GetView<SurplusesDetailsController> {
  const SurplusesDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SurplusesDetailsController>(
        init: SurplusesDetailsController(),
        builder: (_) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Image.network(
                // 'assets/images/surpluses_image.png',
                // Get.arguments['image'],
                controller.arguments['image'],
                width: Get.width,
                height: 308.h,
                fit: BoxFit.cover,
              ),

              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    25.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 9, bottom: 9, left: 7, right: 11),
                            decoration: const BoxDecoration(
                              color: Constants.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 16.w,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 9.w,
                            vertical: 9.h,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/share.png',
                            width: 16.w,
                            color: Constants.primaryColor,
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 27.w),
                    175.ph,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 15.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.r),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CountdownTimer(
                            endTime: DateTime.now().millisecondsSinceEpoch +
                                1000 *
                                    int.parse(controller
                                        .arguments['remainingTime']
                                        .toString()),
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            widgetBuilder: (_, time) {
                              if (time == null) {
                                return Text(
                                  'انتهت المناقصة',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF8E8E8E),
                                  ),
                                );
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${time.hours == null ? "00" : time.hours.toString().padLeft(2, '0')}:${time.min == null ? "00" : time.min.toString().padLeft(2, '0')}:${time.sec == null ? "00" : time.sec.toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                          color: Constants.primaryColor,
                                          fontSize: 15.sp,
                                          letterSpacing: -0.24,
                                        ),
                                      ),
                                      6.pw,
                                      Icon(
                                        Icons.timer_sharp,
                                        size: 18.w,
                                        color: Constants.primaryColor,
                                      ),
                                    ],
                                  ),
                                  5.ph,
                                  Text(
                                    'تنتهي المناقصة خلال',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: const Color(0xFF8E8E8E),
                                    ),
                                  ),
                                ],
                              );
                            },
                            endWidget: const Text(
                              "",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            onEnd: () {},
                          ),
                          controller.listProposals.isEmpty
                              ? Text(
                                  'لا يوجد عروض',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF8E8E8E),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${controller.listProposals.last['price']} دينار',
                                      style: TextStyle(
                                        color: Constants.primaryColor,
                                        fontSize: 15.sp,
                                        letterSpacing: -0.24,
                                      ),
                                    ),
                                    5.ph,
                                    Text(
                                      'أعلى سعر',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: const Color(0xFF8E8E8E),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ).paddingSymmetric(horizontal: 62.w),
                    33.ph,
                    Container(
                      margin: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 33.h),
                      padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            controller.arguments['name'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            controller.arguments['description'],
                            style: const TextStyle(
                                color: Colors.black45, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'العروض',
                      style: TextStyle(
                        fontSize: 13.sp,
                        letterSpacing: -0.24,
                      ),
                    ).paddingOnly(right: 28.w, bottom: 8.h),
                    const Divider(
                      thickness: 1,
                      color: Color(0xFFDDDDDD),
                    ).paddingSymmetric(horizontal: 20.w),
                    controller.loadingProposals
                        ? const Expanded(
                            child: OffersShimmer(),
                          )
                        : Expanded(
                            child: (controller.listProposals).isEmpty
                                ? Center(
                                    child: Text(
                                      'لا يوجد عروض',
                                      style: TextStyle(
                                          fontSize: 16.sp, color: Colors.black),
                                    ),
                                  )
                                : ListView.separated(
                                    padding: EdgeInsets.only(top: 23.h),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: controller.listProposals.length,
                                    separatorBuilder: (context, index) => 17.ph,
                                    itemBuilder: (context, index) {
                                      controller.listProposals.sort((a, b) =>
                                          b['price'].compareTo(a['price']));

                                      ///
                                      // controller.listProposals.sort((a, b) =>
                                      //     b["price"].toString().compareTo(
                                      //         a["price"].toString()));
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 1),
                                              blurRadius: 4,
                                              color: const Color(0xFF737373)
                                                  .withOpacity(0.25),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading:controller.listProposals[index]
                                          ['user']['image']==null? CircleAvatar(
                                            radius: 33.r,
                                            backgroundColor: const Color(0xFFbdc3c7),
                                            child: const Icon(Icons.perm_identity,color: Colors.white,),
                                          ) : CircleAvatar(
                                            radius: 33.r,
                                            backgroundImage: NetworkImage(
                                                controller.listProposals[index]
                                                ['user']['image']),
                                          ),
                                          title: Text(
                                            controller.listProposals[index]
                                                ['user']['name'],
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              letterSpacing: -0.24,
                                              color: const Color(0xFF8E8E8E),
                                            ),
                                          ),
                                          trailing: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 6.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Constants.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                            ),
                                            child: Text(
                                              '${controller.listProposals[index]['price'].toString()} دينار',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13.sp,
                                                letterSpacing: -0.24,
                                              ),
                                            ),
                                          ),
                                        ).paddingSymmetric(horizontal: 15.w),
                                      ).paddingSymmetric(horizontal: 20.w);
                                    },
                                  ),
                          ),
                  ],
                ),
              ),

              /// Shadow & Button
              controller.loadingProposals
                  ? const SizedBox()
                  : CountdownTimer(
                      endTime: DateTime.now().millisecondsSinceEpoch +
                          1000 *
                              int.parse(controller.arguments['remainingTime']
                                  .toString()),
                      widgetBuilder: (_, time) {
                        if (time == null) {
                          return const SizedBox();
                        }
                        return Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 100.h,
                            width: Get.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Constants.primaryColor.withOpacity(0.5),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      endWidget: const Text(""),
                    ),
              controller.loadingProposals
                  ? const SizedBox()
                  : CountdownTimer(
                endTime: DateTime.now().millisecondsSinceEpoch +
                    1000 *
                        int.parse(controller.arguments['remainingTime']
                            .toString()),
                widgetBuilder: (_, time) {
                  if (time == null) {
                    return const SizedBox();
                  }
                  return
                    Global.user['id']==controller.arguments['user']['_id']? const SizedBox() :
                    Positioned(
                    left: 130.w,
                    right: 130.w,
                    bottom: 23.h,
                    child: SizedBox(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            buildDefaultDialog();
                          },
                          icon: Image.asset(
                            'assets/images/bid1.png',
                            width: 43.w,
                            height: 43.h,
                            fit: BoxFit.cover,
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11.r),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Constants.primaryColor,
                            ),
                          ),
                          label: const Text(
                            "مزايدة",
                            style: TextStyle(
                                color: Colors.white, fontSize: 16),
                          ).paddingOnly(top: 23, bottom: 23),
                        ),
                      ),
                    ),
                  );
                },
                endWidget: const Text(""),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> buildDefaultDialog() {
    return Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(
        vertical: 32.h,
        horizontal: 60.w,
      ),
      title: 'للمزايدة',
      content: TextFieldWidget(
        label: 'أضف سعر أعلى',
        textInputType: TextInputType.number,
        radius: 5.r,
        labelColor: const Color(0xFFAFAFAF),
        controller: controller.priceController,
      ),
      actions: [
        ElevatedButton(
          onPressed: () => controller.validate(),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              Constants.primaryColor,
            ),
          ),
          child: const Text(
            "إضافة",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ).paddingOnly(top: 12, bottom: 12),
        ),
      ],
    );
  }
}
