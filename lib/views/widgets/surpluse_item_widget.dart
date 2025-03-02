import 'package:almetlaa/controller/surpluses_controller.dart';
import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class SurplusItemWidget extends StatelessWidget {
  const SurplusItemWidget({super.key, required this.item, required this.controller});

  final Map item;
  final SurplusesController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.surplusesDetailsPage,
          arguments: item,
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.network(
                  // 'assets/images/surpluses_image.png',
                  item['image'],
                  width: Get.width,
                  height: 143.h,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 9.w,
                  bottom: -13.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Text(
                      '${item['price']} دينار',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        letterSpacing: -0.24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 100.w,
                  bottom: -13.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          blurRadius: 2,
                          color: const Color(0xFFA8A8A8).withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CountdownTimer(
                          endTime: DateTime.now().millisecondsSinceEpoch +
                              1000 * int.parse(item['remainingTime'].toString()),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          widgetBuilder: (_, time) {
                            if (time == null) {
                              return Text(
                                'انتهت المزايدة',
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
                                    time.days==0?
                                    Text(
                                      '${time.hours == null ? "00" : time.hours.toString().padLeft(2, '0')}:${time.min == null ? "00" : time.min.toString().padLeft(2, '0')}:${time.sec == null ? "00" : time.sec.toString().padLeft(2, '0')}',
                                      style: TextStyle(
                                        color: Constants.primaryColor,
                                        fontSize: 15.sp,
                                        letterSpacing: -0.24,
                                      ),
                                    ) :
                                    Text(
                                      '${time.days!+1} أيام',
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
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        // Text(
                        //   item['remainingTime']
                        //       .toString(),
                        //   style: TextStyle(
                        //     color: const Color(
                        //         0xFFA5A5A5),
                        //     fontSize: 13.sp,
                        //     letterSpacing: -0.24,
                        //   ),
                        // ),
                        10.pw,
                        Icon(
                          Icons.timer_sharp,
                          size: 19.w,
                          color: const Color(0xFFA5A5A5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            30.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  item['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    letterSpacing: -0.24,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/share.png',
                      width: 20.w,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
              ],
            ).paddingOnly(right: 17.w, left: 10.w, bottom: 10.w),
          ],
        ),
      ),
    );
  }
}
