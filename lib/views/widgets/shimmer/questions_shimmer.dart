import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class QuestionsShimmer extends StatelessWidget {
  const QuestionsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        padding: EdgeInsets.all(20.h),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 20,
        separatorBuilder: (context, index) => 13.ph,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                width: 1,
                color: const Color(0xffD9D9D9),
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                '━━━━━━',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                ),
              ),
              trailing: Icon(Icons.keyboard_arrow_down, size: 40.h),
            ),
          );
        },
      ),
    );
  }
}
