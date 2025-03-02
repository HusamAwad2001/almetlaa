import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class MesVoisinShimmer extends StatelessWidget {
  const MesVoisinShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: AlignedGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 30.h),
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        shrinkWrap: true,
        itemCount: 12,
        crossAxisCount: 1,
        itemBuilder: (_, index) {
          return Container(
            padding: EdgeInsets.all(20.w),
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: const Color(0xFFF0F0F0),
                width: 2,
              ),
            ),
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "━━━━━━━━━━━━━━━━━━━",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                25.ph,
                Text(
                  "━━━━━━━━━━━━━━━━━━━━━━━━━━",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                25.ph,
                Text(
                  "━━━━━━━━━━━━",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
