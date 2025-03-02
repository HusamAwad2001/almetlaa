import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class OffersShimmer extends StatelessWidget {
  const OffersShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: AlignedGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 23.h),
        mainAxisSpacing: 32.h,
        crossAxisSpacing: 33.w,
        shrinkWrap: true,
        itemCount: 12,
        crossAxisCount: 1,
        itemBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white30,
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
              leading: CircleAvatar(
                radius: 33.r,
                backgroundColor: Colors.white,
              ),
              title: Text(
                '━━━━━',
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
                  color: const Color(0xFF0466C0),
                  borderRadius:
                  BorderRadius.circular(5.r),
                ),
                child: Text(
                  '━━━━━',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ).paddingSymmetric(horizontal: 15.w),
          ).paddingSymmetric(horizontal: 20.w);
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              border: Border.all(color: Colors.grey,width: 0.5),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                    color: Colors.grey
                  ),
                  width: 160.w,
                  height: 117.h,
                ),
                4.ph,
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
                4.ph,
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
