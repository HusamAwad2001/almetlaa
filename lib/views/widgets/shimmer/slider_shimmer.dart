import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SliderShimmer extends StatelessWidget {
  const SliderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     SizedBox(
    //       height: 220.h,
    //       child: ListView.builder(
    //         scrollDirection: Axis.horizontal,
    //         itemCount: 3, // عدد الشيمر الوهمي
    //         padding: EdgeInsets.symmetric(horizontal: 6.w),
    //         itemBuilder: (context, index) {
    //           return Container(
    //             width: 320.w,
    //             margin: EdgeInsets.symmetric(horizontal: 6.w),
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(20.r),
    //               boxShadow: [
    //                 BoxShadow(
    //                   color: Colors.black.withOpacity(0.1),
    //                   blurRadius: 10,
    //                   offset: const Offset(0, 4),
    //                 ),
    //               ],
    //             ),
    //             child: Shimmer.fromColors(
    //               baseColor: Colors.grey[300]!,
    //               highlightColor: Colors.grey[100]!,
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(20.r),
    //                 child: Stack(
    //                   fit: StackFit.expand,
    //                   children: [
    //                     Container(
    //                       color: Colors.white,
    //                     ),
    //                     Container(
    //                       decoration: BoxDecoration(
    //                         gradient: LinearGradient(
    //                           begin: Alignment.bottomCenter,
    //                           end: Alignment.topCenter,
    //                           colors: [
    //                             Colors.black.withOpacity(0.2),
    //                             Colors.transparent,
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //     const SizedBox(height: 10),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: List.generate(
    //         3,
    //         (index) => Container(
    //           margin: const EdgeInsets.symmetric(horizontal: 4),
    //           height: 8,
    //           width: index == 0 ? 20 : 8,
    //           decoration: BoxDecoration(
    //             color: Colors.grey[300],
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          carousel_slider.CarouselSlider(
            options: carousel_slider.CarouselOptions(
              height: 220.h,
              // viewportFraction: 0.92,
              enlargeCenterPage: true,
              autoPlay: false,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 350,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 2, 3, 4, 5]
                .map(
                  (e) => Container(
                    width: 8.w,
                    height: 8.h,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 2.w,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: e == 1
                          ? const Color(0xFF0C4797)
                          : const Color(0xFFD9D9D9),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
