import '../../views/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../values/constants.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.item, required this.onTap});

  final Map item;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xffD9D9D9),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            AppImage(imageUrl: item['image'], height: 40.h),
            SizedBox(
              height: 10.h,
            ),
            Text(
              item['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 8.sp, color: Constants.primaryColor),
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
