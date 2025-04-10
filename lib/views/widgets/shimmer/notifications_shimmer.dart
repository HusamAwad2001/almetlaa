import '../../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class NotificationsShimmer extends StatelessWidget {
  const NotificationsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        itemCount: 20,
        separatorBuilder: (context, index) => 10.ph,
        itemBuilder: (context, index) {
          return DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey, width: 1)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("━━━━━━━━━━", style: TextStyle(fontSize: 14.sp)),
                      5.ph,
                      Text(
                        "━━━━━━━━━━━━━━━━━",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                          height: 1.8,
                        ),
                      ),
                      5.ph,
                      Text(
                        "━━━━━━━━",
                        style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                10.pw,
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.close, color: Colors.grey, size: 20.w),
                ),
              ],
            ).paddingAll(15),
          );
        },
      ),
    );
  }
}
