import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban/core/styles/app_colors.dart';
import 'package:kanban/core/values/constants/image_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: Image.asset(
            ImageConstants.logoImage,
            height: 120.h,
            width: 120.h,
          ),
        ),
      ),
    );
  }
}
