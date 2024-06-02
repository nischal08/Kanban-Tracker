import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

gapH(double height) {
  return SizedBox(height: height.h);
}

gapW(double height) {
  return SizedBox(height: height.w);
}

class AppSizes {
  static const double paddingSm = 4.0;
  static const double padding = 8;
  static const double paddingLg = 16.0;
  static const double radius = 8.0;
  static double iconHeight = 20.h;
  static double googleMarkerHeight = 34.h;
  static const constantAspectRatio = (20 / 9);
}
