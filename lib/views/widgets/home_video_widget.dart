import '../../views/dialogs/video_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeVideoWidget extends StatelessWidget {
  const HomeVideoWidget({
    super.key,
    required this.item,
    required this.fullWidth,
    this.onTap,
  });

  final Map item;
  final bool fullWidth;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            VideoDialog().dialog(item);
          },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 5.h),
        child: Stack(
          children: [
            SizedBox(
              height: 126.h,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: fullWidth
                    ? Image.network(
                        item['image'],
                        fit: BoxFit.cover,
                        height: 126.h,
                        width: double.infinity,
                      )
                    : Image.network(
                        item['image'],
                        fit: BoxFit.cover,
                        height: 126.h,
                      ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 70.h,
                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.85),
                      ],
                      stops: const [0.0, 1.0],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  child: Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).paddingOnly(
                    bottom: 13.h,
                    right: 20.h,
                    left: 4.h,
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
