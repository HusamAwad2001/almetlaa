import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble().h);
  SizedBox get pw => SizedBox(width: toDouble().w);
}

class Constants {
  static const String baseURL = "https://almitlae-1.onrender.com/api/v1";

  // static const Color primaryColor = Color(0xFFe56d51);
  static const Color primaryColor = Color(0xFFea6e56);
  static const Color darkPrimaryColor = Color(0xFFc94424);
}
