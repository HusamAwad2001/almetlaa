import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble().h);
  SizedBox get pw => SizedBox(width: toDouble().w);
}

class Constants {
  static const String baseURL =
      // "https://dolphin-app-792st.ondigitalocean.app/api/v1";
      "https://almitlae.onrender.com/api/v1";
  static const Color primaryColor = Color(0xFFdba626);
  static const Color darkPrimaryColor = Color(0xFFc99724);
}
