import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

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
              height: 10.h,
            ),
            AlignedGridView.count(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              shrinkWrap: true,
              itemCount: 40,
              crossAxisCount: 3,
              itemBuilder: (_, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xffD9D9D9),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        height: 40.h,
                        width: 40.h,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "━━━",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10.sp, color: const Color(0xFF01367C)),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                );
              },
            ).paddingOnly(left: 10.w, right: 10.w),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
