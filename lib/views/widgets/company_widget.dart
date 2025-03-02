import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyWidget extends StatelessWidget {
  const CompanyWidget({Key? key, required this.item, required this.onTap})
      : super(key: key);

  final Map item;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF585858).withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.h),
            CircleAvatar(
              radius: 36.r,
              backgroundImage: NetworkImage(item['images'][0]),
            ),
            SizedBox(height: 16.h),
            Text(
              item['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 9.h),
            Text(
              item['description'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                  item['city'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
