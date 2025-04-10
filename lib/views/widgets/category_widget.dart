import '../../views/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../values/constants.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  final Map item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      splashColor: Constants.primaryColor.withOpacity(0.1),
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xffE0E0E0), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImage(
              imageUrl: item['image'],
              height: 45.h,
              fit: BoxFit.contain,
              color: Constants.darkPrimaryColor,
            ),
            SizedBox(height: 10.h),
            Text(
              item['name'],
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                // color: Constants.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import '../../views/widgets/app_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../values/constants.dart';

// class CategoryWidget extends StatelessWidget {
//   const CategoryWidget({super.key, required this.item, required this.onTap});

//   final Map item;
//   final Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: const Color(0xffD9D9D9),
//           ),
//           borderRadius: BorderRadius.all(
//             Radius.circular(20.r),
//           ),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF000000).withOpacity(0.25),
//               spreadRadius: 0,
//               blurRadius: 5,
//               offset: const Offset(2, 2), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 15.h,
//             ),
//             AppImage(imageUrl: item['image'], height: 40.h),
//             SizedBox(
//               height: 10.h,
//             ),
//             Text(
//               item['name'],
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontSize: 8.sp, color: Constants.primaryColor),
//             ),
//             SizedBox(
//               height: 15.h,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
