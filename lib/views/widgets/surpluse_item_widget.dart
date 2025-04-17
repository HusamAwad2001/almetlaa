import '../../controller/surpluses_controller.dart';
import '../../values/constants.dart';
import '../../views/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class SurplusItemWidget extends GetView<SurplusesController> {
  final Map item;
  const SurplusItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey(item['_id']),
      onTap: () {
        final controller = Get.find<SurplusesController>();
        final id = item['_id'];
        final remainingTime = controller.remainingTimeMap[id] ?? Duration.zero;

        Get.toNamed(
          Routes.surplusesDetailsPage,
          arguments: {
            'item': item,
            'remainingTime': remainingTime,
          },
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: item['_id'],
                      child: AppImage(
                        imageUrl: item['image'],
                        width: Get.width,
                        height: 160.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.25),
                            ],
                            stops: const [0.6, 1],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 12.w,
                  bottom: -16.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 6,
                          color: Colors.black.withOpacity(0.16),
                        ),
                      ],
                    ),
                    child: Text(
                      '${item['price']} دينار',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 12.w,
                  bottom: -16.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 6,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GetBuilder<SurplusesController>(
                          id: 'countdown-${item['_id']}',
                          builder: (controller) {
                            final duration =
                                controller.remainingTimeMap[item['_id']] ??
                                    Duration.zero;

                            if (duration.inSeconds <= 0) {
                              return Text(
                                'انتهت المزايدة',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF8E8E8E),
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }

                            final hours = duration.inHours;
                            final minutes = duration.inMinutes % 60;
                            final seconds = duration.inSeconds % 60;

                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.timer_rounded,
                                  size: 18.w,
                                  color: Constants.primaryColor,
                                ),
                                8.pw,
                                Text(
                                  'تنتهي خلال',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xFF8E8E8E),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                8.pw,
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color:
                                        Constants.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    duration.inDays == 0
                                        ? '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'
                                        : '${duration.inDays + 1} أيام',
                                    style: TextStyle(
                                      color: Constants.primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
              child: Text(
                item['name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
