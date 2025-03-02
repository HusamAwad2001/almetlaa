import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SliderShimmer extends StatelessWidget {
  const SliderShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          carousel_slider.CarouselSlider(
            options: carousel_slider.CarouselOptions(
              height: 350,
              viewportFraction: 1,
              autoPlay: false,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (context) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
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
