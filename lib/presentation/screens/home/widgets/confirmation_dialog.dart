import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban/core/styles/app_sizes.dart';
import 'package:kanban/core/styles/text_styles.dart';
import 'package:kanban/presentation/widgets/general_elevated_button.dart';
import 'package:kanban/presentation/widgets/general_text_button.dart';

class BoardCardEditDialog extends StatelessWidget {
  const BoardCardEditDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.only(
          top: 32.h,
          bottom: 24.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
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
            horizontal: 24.w,
          ),
          child: Text(
            "Edit your data",
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
            horizontal: 40.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: GeneralTextButton(
                  height: 49.h,
                  width: 124.w,
                  title: "No",
                  borderRadius: 4.r,
                  borderColor: Colors.transparent,
                  fgColor: Colors.black,
                  bgColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              gapW(47),
              Flexible(
                child: GeneralElevatedButton(
                  width: 124.w,
                  height: 49.h,
                  title: "Yes",
                  textStyle: generalTextStyle(24, 32.78).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  borderRadius: 4.r,
                  onPressed: () {
                    Navigator.of(context).pop();
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
