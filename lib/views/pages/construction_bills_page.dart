import 'package:almetlaa/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/construction_bills_controller.dart';
import '../../routes/routes.dart';
import '../widgets/pdf/pdf_creator.dart';

class ConstructionBillsPage extends StatelessWidget {
  const ConstructionBillsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text("فواتيري",style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
      ),
      body: GetBuilder<ConstructionBillsController>(
        init: ConstructionBillsController(),
        builder: (controller) {
          return controller.loadingBills
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(width: Get.width),
                      45.ph,
                      Container(
                        width: 250.w,
                        padding: EdgeInsets.symmetric(vertical: 27.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFA5A5A5).withOpacity(0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'إجمالي المدفوعات',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            15.ph,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  controller.totalAmount.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.primaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  ' د.ك',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      45.ph,
                      controller.listAllBills.isEmpty
                          ? const Center(child: Text('لا يوجد بنود'))
                          : ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.listAllBills.length,
                              separatorBuilder: (context, index) => 20.ph,
                              itemBuilder: (context, index) {
                                final item = controller.listAllBills[index];
                                return _ItemBill(
                                  title: item['name'],
                                  price: item['total'].toString(),
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.contractBillsPage,
                                      arguments: item['name'],
                                    );
                                    controller.getMyBills(item['_id']);
                                  },
                                );
                              },
                            ),
                      60.ph,
                      controller.listAllBills.isEmpty
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: () {
                                PdfGenerator.createGeneralPdf(
                                  total: "${controller.totalAmount}د.ك",
                                  listAllBills: controller.listAllBills
                                );
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  Constants.primaryColor,
                                ),
                              ),
                              child: const Text(
                                "تنزيل ملف PDF",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ).paddingOnly(top: 20.h, bottom: 20.h),
                            ),
                      20.ph,
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class _ItemBill extends StatelessWidget {
  final String title;
  final String price;
  final Function() onTap;

  const _ItemBill({
    Key? key,
    required this.title,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(23.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF616161).withOpacity(0.25),
              blurRadius: 4,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
            const Spacer(),
            FittedBox(
              child: Text(
                '$price دينار',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: const Color(0xFF3BB900),
                ),
              ),
            ),
            95.pw,
            Icon(Icons.arrow_forward_ios, size: 15.w),
          ],
        ),
      ),
    );
  }
}
