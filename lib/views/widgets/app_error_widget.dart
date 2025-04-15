import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../values/constants.dart';

class AppErrorWidget extends StatelessWidget {
  final String errorMessage;
  final Function onRetry;
  const AppErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '⚠️',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50.sp,
              color: Constants.primaryColor,
            ),
          ),
          Center(
            child: Text(
              errorMessage,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          20.ph,
          OutlinedButton.icon(
            onPressed: onRetry as void Function()?,
            icon: const Icon(
              Icons.refresh,
              color: Constants.primaryColor,
              size: 24,
            ),
            label: const Text(
              "حاول مرة أخرى",
              style: TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                fontFamily: 'amarai',
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Constants.primaryColor.withValues(alpha: 0.2),
              side: const BorderSide(
                color: Constants.primaryColor,
              ),
              padding: EdgeInsets.symmetric(vertical: 15.h),
              textStyle: TextStyle(fontSize: 14.sp),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
