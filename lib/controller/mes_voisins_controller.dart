import 'package:almetlaa/values/constants.dart';
import 'package:almetlaa/views/widgets/loading_dialog.dart';
import 'package:almetlaa/views/widgets/snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/global.dart';
import '../routes/routes.dart';
import '../utils/api.dart';

class MesVoisinsController extends GetxController {
  final suburbsController = TextEditingController();
  final widgetController = TextEditingController();
  final couponNumberController = TextEditingController();

  @override
  void onInit() {
    getIsAddress();
    getRegions();
    super.onInit();
  }

  bool isAddress = false;
  bool loadingAddress = true;

  getIsAddress() {
    API().get(
      url: '/auth/isAddress',
      onResponse: (response) {
        loadingAddress = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            isAddress = response.data['data'];
            print(response.data['data']);
          }
        }
        update();
      },
    );
  }

  List regions = [];
  bool loadingRegions = true;

  getRegions() {
    API().get(
      url: '/auth/myNeighbors',
      onResponse: (response) {
        loadingRegions = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            regions = response.data['data'];
          }
        }
        update();
      },
    );
  }

  List suburbs = [];
  String? suburbId;
  bool loadingSuburbs = true;

  getSuburbs() {
    LoadingDialog().dialog();
    API().get(
      url: '/suburbs',
      onResponse: (response) {
        loadingSuburbs = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            suburbs = response.data['data'];
          }
        }
        Get.back();
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
            child: Column(
              children: [
                20.ph,
                Text(
                  'اختر الضاحية',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
                15.ph,
                Column(
                  children: suburbs
                      .map((e) => Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF01367C).withOpacity(.2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            margin: EdgeInsets.only(bottom: 10.h),
                            child: ListTile(
                              onTap: () {
                                suburbsController.text = e['name'];
                                suburbId = e['_id'];
                                Get.back();
                                update();
                              },
                              leading: CircleAvatar(
                                radius: 10.r,
                                backgroundColor: Colors.black.withOpacity(0.2),
                              ),
                              title: Text(e['name']),
                              trailing: const Icon(Icons.autofps_select),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        );
        update();
      },
    );
  }

  List widgets = [];
  String? widgetId;
  bool loadingWidgets = true;

  getWidgets() {
    LoadingDialog().dialog();
    API().get(
      url: '/widgets?suburb=$suburbId',
      onResponse: (response) {
        loadingWidgets = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            widgets = response.data['data'] ?? [];
          }
        }
        Get.back();
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
            child: Column(
              children: [
                20.ph,
                Text(
                  'اختر القسيمة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                  ),
                ),
                15.ph,
                Column(
                  children: widgets
                      .map((e) => Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF01367C).withOpacity(.2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            margin: EdgeInsets.only(bottom: 10.h),
                            child: ListTile(
                              onTap: () {
                                widgetController.text = e['name'];
                                widgetId = e['_id'];
                                Get.back();
                                update();
                              },
                              leading: CircleAvatar(
                                radius: 10.r,
                                backgroundColor: Colors.black.withOpacity(0.2),
                              ),
                              title: Text(e['name']),
                              trailing: const Icon(Icons.autofps_select),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        );
        update();
      },
    );
  }

  addMyAddress() {
    LoadingDialog().dialog();
    API().post(
      url: '/auth/addMyAddress',
      body: {
        'widget': widgetId,
        'suburb': suburbId,
        'couponNumber': couponNumberController.text.trim(),
      },
      onResponse: (response) {
        loadingWidgets = false;
        if (response.statusCode == 200) {
          if (response.data['success']) {
            widgetController.clear();
            suburbsController.clear();
            couponNumberController.clear();
            Get.back();
            print(response.data['data']);
          }
        }
        Get.back();
        update();
      },
    );
  }

  validate() {
    if (Global.token.isEmpty || Global.user.isEmpty) {
      Snack().show(type: false, message: 'يرجى تسجيل الدخول');
      Get.offAllNamed(Routes.loginPage);
      return;
    }
    if (suburbsController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى اختيار الضاحية');
      return;
    }
    if (widgetController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى اختيار القسيمة');
      return;
    }
    if (couponNumberController.text.isEmpty) {
      Snack().show(type: false, message: 'يرجى كتابة رقم القسيمة');
      return;
    }
    addMyAddress();
    update();
  }
}
