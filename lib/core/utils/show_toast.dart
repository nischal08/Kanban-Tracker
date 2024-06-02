import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kanban/core/styles/app_colors.dart';
import 'package:kanban/core/styles/app_sizes.dart';
import 'package:kanban/core/values/routes_config.dart';

FToast fToast = FToast();

///Keyboard is automatically closed when toast is displayed.
///You can disable it, resulting in toast taking extra .5 seconds delay before it displays
void showToast(
  String text, {
  bool isEmergency = false,
  bool unFocusKeyboard = true,
}) async {
  final context = navKey.currentState!.context;
  if (unFocusKeyboard) {
    FocusScope.of(context).unfocus();
    log("Toast Closed the Keyboard");
  }
  if (context.mounted) {
    final toast = Container(
      padding: const EdgeInsets.all(AppSizes.paddingLg / 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius),
        color:
            isEmergency ? AppColors.emergencyBgColor : AppColors.alertBgColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isEmergency
              ? AppColors.emergencyTextColor
              : AppColors.alertTextColor,
        ),
      ),
    );
    fToast.init(context);
   
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(
        seconds: 2,
      ),
      gravity: ToastGravity.BOTTOM,
    );
  }
}
