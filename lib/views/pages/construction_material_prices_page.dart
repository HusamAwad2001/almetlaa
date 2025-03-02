import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConstructionMaterialPricesPage extends StatelessWidget {
  const ConstructionMaterialPricesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Text(
          "أسعار المواد الإنشائية",
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: const SizedBox(),
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_forward_ios),
          ),
          10.pw,
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'البحث',
                    prefixIcon: Container(
                      width: 22.w,
                      height: 22.h,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/search.png',
                        width: 22.w,
                        height: 22.h,
                        color: Constants.primaryColor,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.r),
                      borderSide:
                          const BorderSide(width: 1, color: Color(0xFFF0F0F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9.r),
                      borderSide:
                          const BorderSide(width: 1, color: Color(0xFFF0F0F0)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                  ),
                ),
              ),
              32.pw,
              Container(
                width: 45.w,
                height: 45.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: const Color(0xFFF0F0F0),
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/filter.png',
                  width: 25.w,
                  height: 25.h,
                ),
              ),
            ],
          ).paddingOnly(
            right: 31.w,
            left: 21.w,
            top: 30.h,
          ),
          //
          65.ph,
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            padding: EdgeInsets.only(bottom: 35.h, top: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Table(
              children: [
                TableRow(
                  children: [
                    Center(
                      child: Text(
                        'المادة',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).paddingOnly(top: 10.h, bottom: 10.h),
                    ),
                    Center(
                      child: Text(
                        'المنشأ',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).paddingOnly(top: 14.h, bottom: 14.h),
                    ),
                    Center(
                      child: Text(
                        'الشدة / القياس',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).paddingOnly(top: 14.h, bottom: 14.h),
                    ),
                    Center(
                      child: Text(
                        'السعر بالفلس',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).paddingOnly(top: 14.h, bottom: 14.h),
                    ),
                    Center(
                      child: Text(
                        'السعر بالدينار',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).paddingOnly(top: 14.h, bottom: 14.h),
                    ),
                  ],
                ),
                TableRow(children: [
                  Center(
                    child: Text(
                      'اسمنت / ابيض',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      'اماراتي / راس الخيمة',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '50 كيلو',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '750',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                ]),
                TableRow(
                    decoration: const BoxDecoration(color: Color(0xFFC2DDFF)),
                    children: [
                      Center(
                        child: Text(
                          'اسمنت / ابيض',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          'اماراتي / راس الخيمة',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '50 كيلو',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '750',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '2',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                    ]),
                TableRow(children: [
                  Center(
                    child: Text(
                      'اسمنت / ابيض',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      'اماراتي / راس الخيمة',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '50 كيلو',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '750',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                ]),
                TableRow(
                    decoration: const BoxDecoration(color: Color(0xFFC2DDFF)),
                    children: [
                      Center(
                        child: Text(
                          'اسمنت / ابيض',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          'اماراتي / راس الخيمة',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '50 كيلو',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '750',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '2',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                    ]),
              ],
            ),
          ),
          31.ph,
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            padding: EdgeInsets.only(bottom: 35.h, top: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Table(
              children: [
                TableRow(
                  children: [
                    Center(
                      child: Text(
                        'المادة',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).paddingOnly(top: 10.h, bottom: 10.h),
                    ),
                    Center(
                      child: Text(
                        'المنشأ',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).paddingOnly(top: 14.h, bottom: 14.h),
                    ),
                    Center(
                      child: Text(
                        'الشدة / القياس',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).paddingOnly(top: 14.h, bottom: 14.h),
                    ),
                    Center(
                      child: Text(
                        'السعر بالفلس',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).paddingOnly(top: 14.h, bottom: 14.h),
                    ),
                    Center(
                      child: Text(
                        'السعر بالدينار',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ).paddingOnly(top: 14.h, bottom: 14.h),
                    ),
                  ],
                ),
                TableRow(children: [
                  Center(
                    child: Text(
                      'اسمنت / ابيض',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      'اماراتي / راس الخيمة',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '50 كيلو',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '750',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                ]),
                TableRow(
                    decoration: const BoxDecoration(color: Color(0xFFC2DDFF)),
                    children: [
                      Center(
                        child: Text(
                          'اسمنت / ابيض',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          'اماراتي / راس الخيمة',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '50 كيلو',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '750',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '2',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                    ]),
                TableRow(children: [
                  Center(
                    child: Text(
                      'اسمنت / ابيض',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      'اماراتي / راس الخيمة',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '50 كيلو',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '750',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                  Center(
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 7.sp),
                    ).paddingOnly(top: 14.h, bottom: 14.h),
                  ),
                ]),
                TableRow(
                    decoration: const BoxDecoration(color: Color(0xFFC2DDFF)),
                    children: [
                      Center(
                        child: Text(
                          'اسمنت / ابيض',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          'اماراتي / راس الخيمة',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '50 كيلو',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '750',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                      Center(
                        child: Text(
                          '2',
                          style: TextStyle(fontSize: 7.sp),
                        ).paddingOnly(top: 14.h, bottom: 14.h),
                      ),
                    ]),
              ],
            ),
          ),
          // 160.ph,
        ],
      ),
    );
  }
}
