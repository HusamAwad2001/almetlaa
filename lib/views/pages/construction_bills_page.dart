import '../../values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/construction_bills_controller.dart';
import '../../routes/routes.dart';
import '../widgets/pdf/pdf_creator.dart';

class ConstructionBillsPage extends StatelessWidget {
  const ConstructionBillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text(
          "فواتيري",
          style: TextStyle(color: Colors.white),
        ),
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        25.ph,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 24.h, horizontal: 20.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.account_balance_wallet_rounded,
                                        color: Constants.primaryColor,
                                        size: 28.sp),
                                    8.pw,
                                    Text(
                                      'إجمالي المدفوعات',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                                16.ph,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.totalAmount.toString(),
                                      style: TextStyle(
                                        color: Constants.primaryColor,
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    4.pw,
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.h),
                                      child: Text(
                                        'د.ك',
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        30.ph,
                        if (controller.listAllBills.isEmpty)
                          const Center(child: Text('لا يوجد بنود'))
                        else
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.listAllBills.length,
                            separatorBuilder: (_, __) => 16.ph,
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
                        40.ph,
                        if (controller.listAllBills.isNotEmpty)
                          ElevatedButton.icon(
                            onPressed: () {
                              PdfGenerator.createGeneralPdf(
                                total: "${controller.totalAmount} د.ك",
                                listAllBills: controller.listAllBills,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Constants.primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            icon: Icon(
                              Icons.picture_as_pdf_outlined,
                              size: 24.w,
                              color: Colors.white,
                            ),
                            label: Text(
                              "تنزيل ملف PDF",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        20.ph,
                      ],
                    ),
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
    required this.title,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '$price د.ك',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Colors.grey,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18.w,
        color: Colors.grey,
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      tileColor: Colors.white,
    );
  }
}
