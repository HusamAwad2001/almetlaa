import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeServiceWidget extends StatelessWidget {
  const HomeServiceWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String image;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 88.w,
        height: 88.h,
        decoration: BoxDecoration(
          color: Constants.primaryColor,
          border: Border.all(
            color: Colors.white,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            14.ph,
            Expanded(child: Image.asset(
              image
            )),
            11.ph,
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
            14.ph,
          ],
        ).paddingSymmetric(horizontal: 5.w),
      ),
    );
  }
}
