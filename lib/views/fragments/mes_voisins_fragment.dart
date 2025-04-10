import '../../values/constants.dart';
import '../../views/widgets/snack.dart';
import '../../views/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controller/mes_voisins_controller.dart';
import '../widgets/shimmer/mes_voisin_shimmer.dart';

class MesVoisinsFragment extends StatelessWidget {
  const MesVoisinsFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "جيراني",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<MesVoisinsController>(
        init: MesVoisinsController(),
        builder: (controller) {
          return controller.loadingAddress
              ? const MesVoisinShimmer()
              : !controller.isAddress
                  ? Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.bottomSheet(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  20.ph,
                                  Text(
                                    'إضافة عنوان جديد',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.sp,
                                    ),
                                  ),
                                  15.ph,
                                  InkWell(
                                    onTap: () => controller.getSuburbs(),
                                    child: TextFieldWidget(
                                      label: 'الضاحية',
                                      controller: controller.suburbsController,
                                      enabled: false,
                                    ),
                                  ),
                                  15.ph,
                                  InkWell(
                                    onTap: () async {
                                      if (controller
                                          .suburbsController.text.isNotEmpty) {
                                        await controller.getWidgets();
                                      } else {
                                        Snack().show(
                                          type: false,
                                          message: 'يرجى اختبار الضاحية أولاً',
                                        );
                                      }
                                    },
                                    child: TextFieldWidget(
                                      label: 'القسيمة',
                                      controller: controller.widgetController,
                                      enabled: false,
                                    ),
                                  ),
                                  15.ph,
                                  TextFieldWidget(
                                    label: 'رقم القسيمة',
                                    controller:
                                        controller.couponNumberController,
                                  ),
                                  30.ph,
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      onPressed: () => controller.validate(),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            side: BorderSide(
                                              color: Constants.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "إضافة",
                                        style: TextStyle(
                                            color: Constants.primaryColor,
                                            fontSize: 16),
                                      ).paddingOnly(top: 10.h, bottom: 10.h),
                                    ),
                                  ),
                                  50.ph,
                                ],
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.primaryColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 15.h,
                          ),
                        ),
                        child: const Text(
                          'أضف عنوان جديد',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : controller.loadingRegions
                      ? const MesVoisinShimmer()
                      : controller.regions.isEmpty
                          ? Center(
                              child: Text(
                                'لا يوجد جيران',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                ),
                              ),
                            )
                          : Column(
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
                                            borderRadius:
                                                BorderRadius.circular(9.r),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFF0F0F0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9.r),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFFF0F0F0)),
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xFFF5F5F5),
                                        ),
                                      ),
                                    ),
                                    20.pw,
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        // width: 45.w,
                                        // height: 45.h,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
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
                                    ),
                                  ],
                                ).paddingOnly(
                                  right: 21.w,
                                  left: 23.w,
                                  top: 30.h,
                                ),
                                Expanded(
                                  child: ListView.separated(
                                    padding: EdgeInsets.only(top: 32.h),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: controller.regions.length,
                                    separatorBuilder: (context, index) => 10.ph,
                                    itemBuilder: (context, index) {
                                      final item = controller.regions[index];
                                      return Container(
                                        padding: EdgeInsets.all(20.w),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          border: Border.all(
                                            color: const Color(0xFFF0F0F0),
                                            width: 2,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/profile.svg',
                                                  width: 25.w,
                                                  color: Colors.black,
                                                ),
                                                18.pw,
                                                Text(
                                                  item['name'],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            25.ph,
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/location.svg',
                                                  width: 25.w,
                                                  color: Colors.black,
                                                ),
                                                18.pw,
                                                Text(
                                                  'ضاحية ${item['suburb']['name']}  توزيعة ${item['widget']['name']}  قسيمة ${item['couponNumber']}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color:
                                                        Constants.primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            25.ph,
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/phone.svg',
                                                  width: 25.w,
                                                  color: Colors.black,
                                                ),
                                                18.pw,
                                                Text(
                                                  item['phoneNumber'],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color:
                                                        Constants.primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
        },
      ),
    );
  }
}
