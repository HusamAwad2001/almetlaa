import '../../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class NewsShimmer extends StatelessWidget {
  const NewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: AlignedGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        mainAxisSpacing: 25.h,
        crossAxisSpacing: 25.w,
        shrinkWrap: true,
        itemCount: 12,
        crossAxisCount: 2,
        itemBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              border: Border.all(color: Colors.grey, width: 0.5),
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
                  width: double.infinity,
                  height: 117.h,
                ),
                7.ph,
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "━━━━━━━━━━━━━━━━━━━━━━━━━━",
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
                    "━━━━━━━━━━━━━━━━━━━━━━━━━━",
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
          );
          // return HomeNewsWidget(item: controller.news[index]);
        },
      ),
    );
  }
}
