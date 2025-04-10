import '../../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SurplusesShimmer extends StatelessWidget {
  const SurplusesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: AlignedGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 32.h),
        mainAxisSpacing: 32.h,
        crossAxisSpacing: 33.w,
        shrinkWrap: true,
        itemCount: 12,
        crossAxisCount: 1,
        itemBuilder: (_, index) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.transparent,
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
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                      color: Colors.grey),
                  width: Get.width,
                  height: 143.h,
                ),
                30.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '━━━━━',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        letterSpacing: -0.24,
                        color: const Color(0xFFA8A8A8),
                      ),
                    ),
                    Container(
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
                        color: const Color(0xFF0466C0),
                      ),
                    ),
                  ],
                ).paddingOnly(right: 17.w, left: 10.w, bottom: 10.w),
              ],
            ),
          );
        },
      ).paddingOnly(
        right: 31.w,
        left: 31.w,
      ),
    );
  }
}
