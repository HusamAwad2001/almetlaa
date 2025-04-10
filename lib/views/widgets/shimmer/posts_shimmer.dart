import '../../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class PostsShimmer extends StatelessWidget {
  const PostsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        itemCount: 3,
        separatorBuilder: (_, __) => 29.ph,
        itemBuilder: (_, index) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 190.h,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Colors.grey,
                      ),
                      10.pw,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('━━━━━━', style: TextStyle(fontSize: 14.sp)),
                          5.ph,
                          Text("━━━━",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("0", style: TextStyle(fontSize: 16.sp)),
                          5.pw,
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              color: Color(0xFFe74c3c),
                            ),
                            constraints: const BoxConstraints(),
                          )
                        ],
                      ),
                    ],
                  ).paddingAll(10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
