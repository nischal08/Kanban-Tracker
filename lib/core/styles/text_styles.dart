import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle generalTextStyle(double fontSize, [double? height]) {
  return TextStyle(
    fontSize: fontSize.sp,
    height: height != null ? (height.sp / fontSize.sp) : null,
    color: Colors.black,
  );
}
