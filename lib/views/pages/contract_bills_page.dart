import '../../values/constants.dart';
import '../../views/widgets/dialogs/create_batch_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/construction_bills_controller.dart';
import '../../routes/routes.dart';
import '../widgets/pdf/pdf_creator.dart';

class ContractBillsPage extends GetView<ConstructionBillsController> {
  const ContractBillsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: Text(
          Get.arguments.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<ConstructionBillsController>(
        init: ConstructionBillsController(),
        builder: (_) {
          return controller.loadingMyBills
              ? const Center(child: CircularProgressIndicator())
              : controller.listMyBills.isNotEmpty
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.only(
                                left: 20.w, right: 20.w, top: 53.h),
                            padding: EdgeInsets.only(bottom: 00.h, top: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF000000).withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Table(
                              children: [
                                TableRow(
                                  children: [
                                    Center(
                                      child: Text(
                                        'نوع الدفعة',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ).paddingOnly(top: 14.h, bottom: 14.h),
                                    ),
                                    Center(
                                      child: Text(
                                        'المبلغ',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ).paddingOnly(top: 14.h, bottom: 14.h),
                                    ),
                                    Center(
                                      child: Text(
                                        'التاريخ',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ).paddingOnly(top: 14.h, bottom: 14.h),
                                    ),
                                    Center(
                                      child: Text(
                                        'حذف',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ).paddingOnly(top: 14.h, bottom: 14.h),
                                    ),
                                  ],
                                ),
                                ...controller.listMyBills
                                    .asMap()
                                    .entries
                                    .map((e) {
                                  int index = e.key;
                                  var item = e.value;
                                  return TableRow(
                                    decoration: BoxDecoration(
                                      color: index.isEven
                                          ? const Color(0xFFC2DDFF)
                                          : null,
                                    ),
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          displayBottomInfoSheet(item);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          color: Colors.transparent,
                                          child: Text(
                                            item['batchType'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 13.sp),
                                          ).paddingOnly(
                                              top: 14.h, bottom: 14.h),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          displayBottomInfoSheet(item);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          color: Colors.transparent,
                                          child: Text(
                                            '${item['amount'].toString()} د.ك',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 13.sp),
                                          ).paddingOnly(
                                              top: 14.h, bottom: 14.h),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          displayBottomInfoSheet(item);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          color: Colors.transparent,
                                          child: Text(
                                            item['date'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 13.sp),
                                          ).paddingOnly(
                                              top: 14.h, bottom: 14.h),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          displayBottomSheetRemoveItem(
                                            onTap: () {
                                              controller.deleteBill(
                                                item,
                                                index,
                                              );
                                            },
                                          );
                                        },
                                        child: Center(
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 20.w,
                                          ).paddingOnly(
                                              top: 14.h, bottom: 14.h),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                          20.ph,
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    CreateBatchDialog.show();
                                  },
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    backgroundColor: WidgetStateProperty.all(
                                      Constants.primaryColor,
                                    ),
                                  ),
                                  child: Text(
                                    "إنشاء دفعة جديدة",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.sp),
                                  ).paddingOnly(top: 15.h, bottom: 15.h),
                                ),
                              ),
                              20.pw,
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    PdfGenerator.createPdf(
                                        controller.listMyBills);
                                  },
                                  style: ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    backgroundColor: WidgetStateProperty.all(
                                      Constants.primaryColor,
                                    ),
                                  ),
                                  child: Text(
                                    "تنزيل ملف PDF",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.sp),
                                  ).paddingOnly(top: 15.h, bottom: 15.h),
                                ),
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 20.w),
                          60.ph,
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Center(
                          child: Text(
                            'لا يوجد فواتير',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed(Routes.createBatchPage);
                          },
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                              Constants.primaryColor,
                            ),
                          ),
                          child: Text(
                            "إنشاء دفعة جديدة",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                          ).paddingOnly(top: 15.h, bottom: 15.h),
                        ),
                        60.ph,
                      ],
                    );
        },
      ),
    );
  }

  displayBottomInfoSheet(dynamic item) {
    Get.bottomSheet(
      SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  8.ph,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: SizedBox(
                      width: 250.w,
                      height: 250.h,
                      child: CachedNetworkImage(
                        width: 250.w,
                        height: 250.h,
                        fit: BoxFit.cover,
                        imageUrl: item['image'],
                        fadeInCurve: Curves.easeIn,
                        fadeOutCurve: Curves.easeOut,
                        placeholder: (context, url) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorWidget: (context, url, error) {
                          return const Icon(
                            Icons.error,
                          );
                        },
                      ),
                    ),
                  ),
                  8.ph,
                  ListTile(
                    title: const Text(
                      'نوع الدفعة',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      item['batchType'],
                    ).paddingOnly(top: 7.h),
                  ),
                  ListTile(
                    title: const Text(
                      'المبلغ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle:
                        Text(item['amount'].toString()).paddingOnly(top: 7.h),
                  ),
                  ListTile(
                    title: const Text(
                      'التاريخ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      item['date'],
                    ).paddingOnly(top: 7.h),
                  ),
                ],
              ),
              Positioned(
                top: 10.h,
                left: 10.h,
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.close, size: 20.w, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  displayBottomSheetRemoveItem({required Function() onTap}) {
    return Get.bottomSheet(
      DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            20.ph,
            Text(
              'هل أنت متأكد من حذف الفاتورة ؟',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            35.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onTap,
                  style: buttonStyle(Colors.red),
                  child: const Text(
                    "نعم",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ).paddingOnly(
                    top: 10.h,
                    bottom: 10.h,
                    left: 10.w,
                    right: 10.w,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  style: buttonStyle(Constants.primaryColor),
                  child: const Text(
                    "لا",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ).paddingOnly(
                    top: 10.h,
                    bottom: 10.h,
                    left: 10.w,
                    right: 10.w,
                  ),
                ),
              ],
            ),
            20.ph,
          ],
        ),
      ),
      // backgroundColor: Colors.white,
    );
  }

  buttonStyle(Color backgroundColor) {
    return ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      minimumSize: WidgetStateProperty.all(Size(100.w, 00.h)),
      backgroundColor: WidgetStateProperty.all(backgroundColor),
    );
  }
}
