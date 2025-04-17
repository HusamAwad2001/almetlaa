import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../values/constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.enabled,
    this.suffixIcon,
    this.hintFontWeight,
    this.radius,
    this.labelColor,
    this.maxLines,
    this.inputFormatters,
    required this.label,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
    this.textDirection,
    this.onChange,
    this.prefixIcon,
    required this.controller,
  });

  final String label;
  final bool isPassword;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool? enabled;
  final double? radius;
  final Color? labelColor;
  final FontWeight? hintFontWeight;
  final Widget? suffixIcon;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextDirection? textDirection;
  final Function(String)? onChange;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 100)),
          boxShadow: const [
            BoxShadow(
                color: Color(0xFFD9D9D9),
                offset: Offset(0, 0),
                spreadRadius: 0.5,
                blurRadius: 0.5)
          ]),
      child: TextField(
        textInputAction: TextInputAction.done,
        keyboardType: textInputType,
        textDirection: textDirection,
        style: const TextStyle(color: Constants.primaryColor),
        cursorColor: labelColor ?? Constants.primaryColor,
        controller: controller,
        obscureText: isPassword,
        textAlign: TextAlign.start,
        maxLines: maxLines ?? 1,
        onChanged: onChange,
        inputFormatters: inputFormatters,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon ?? const SizedBox(),
          enabled: enabled ?? true,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 100)),
              borderSide: BorderSide.none),
          isDense: true,
          hintStyle: TextStyle(
            color: labelColor ?? Constants.primaryColor,
            fontSize: 14.sp,
            fontWeight: hintFontWeight ?? FontWeight.normal,
          ),
          contentPadding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: 20.h,
          ),
          hintText: label,
        ),
      ),
    );
  }
}
