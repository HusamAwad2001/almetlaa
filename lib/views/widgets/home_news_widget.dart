import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeNewsWidget extends StatelessWidget {
  const HomeNewsWidget({Key? key, required this.item}) : super(key: key);

  final Map item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 3,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ]),
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            child: Image.network(
              item['image'],
              width: double.infinity,
              height: 117.h,
              fit: BoxFit.cover,
            ),
          ),
          7.ph,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              item['title'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(left: 6.w, right: 10.w),
          ),
          5.ph,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              item['description'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w300,
                color: const Color(0xFF999797),
              ),
            ).paddingOnly(left: 6.w, right: 10.w),
          ),
          10.ph,
        ],
      ),
    );
  }
}
