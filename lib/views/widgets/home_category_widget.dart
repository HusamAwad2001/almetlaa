import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({Key? key, required this.image, required this.title, required this.url})
      : super(key: key);

  final String image;
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          final Uri uri = Uri.parse(url);
          if (!await launchUrl(uri)) {
            throw Exception('Could not launch $uri');
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            border: Border.all(width: 1, color: const Color(0xFFD9D9D9)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.25),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              15.ph,
              Image.asset(
                image,
                height: 35.h,
              ).paddingSymmetric(horizontal: 10.w),
              12.ph,
              FittedBox(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              15.ph,
            ],
          ),
        ),
      ),
    );
  }
}
