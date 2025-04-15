import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../views/widgets/app_image.dart';

import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeNewsWidget extends StatelessWidget {
  final Map item;
  const HomeNewsWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.newsDetailsPage,
        arguments: item,
      ),
      child: Container(
        width: 165.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            width: 1,
            color: const Color(0xffD9D9D9),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Hero(
                tag: item['_id'],
                child: AppImage(
                  imageUrl: item['image'],
                  width: double.infinity,
                  height: 110.h,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Container(
                    height: 110.h,
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image,
                      size: 30.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  4.ph,
                  Text(
                    item['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF777777),
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
