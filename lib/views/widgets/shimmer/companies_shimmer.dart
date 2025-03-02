import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CompaniesShimmer extends StatelessWidget {
  const CompaniesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 38.h,
            ),
            AlignedGridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              shrinkWrap: true,
              itemCount: 40,
              crossAxisCount: 2,
              itemBuilder: (_, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xffD9D9D9),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 16.h),
                      CircleAvatar(radius: 36.r),
                      SizedBox(height: 16.h),
                      Text(
                        '━━━━',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 9.h),
                      Text(
                        '━━━',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 8.sp,
                          color: const Color(0xFF747474),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: const Color(0xFF01367C),
                            size: 12.w,
                          ),
                          SizedBox(height: 5.w),
                          Text(
                            '━━━━━━',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ).paddingOnly(left: 10.w),
                      SizedBox(height: 16.h),
                    ],
                  ),
                );
              },
            ).paddingOnly(left: 10.w, right: 10.w),
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
      ),
    );
  }
}
