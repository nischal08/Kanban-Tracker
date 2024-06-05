import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/core/styles/app_sizes.dart';
import 'package:kanban/core/styles/text_styles.dart';
import 'package:kanban/presentation/widgets/general_elevated_button.dart';
import 'package:kanban/presentation/widgets/general_text_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.only(
          top: 24.h,
          bottom: 24.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: bodyContent(context),
      ),
    );
  }

  Column bodyContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: generalTextStyle(17).copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        gapH(24),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 60.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: GeneralTextButton(
                  height: 32.h,
                  width: 124.w,
                  isMinimumWidth: true,
                  title: "No",
                  borderRadius: 4.r,
                  borderColor:  Colors.transparent,
                  fgColor: Theme.of(context).colorScheme.error,
                  bgColor: Colors.transparent,
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
              gapW(20),
              Flexible(
                child: GeneralElevatedButton(
                  height: 32.h,
                  width: 124.w,
                  isMinimumWidth: true,
                  title: "Yes",
                  borderRadius: 4.r,
                  onPressed: () {
                    context.pop(true);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
