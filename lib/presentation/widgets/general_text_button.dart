import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban/core/styles/app_colors.dart';
import 'package:kanban/core/styles/app_sizes.dart';
import 'package:kanban/core/styles/text_styles.dart';

class GeneralTextButton extends StatelessWidget {
  final String title;
  final Color? bgColor;
  final Color? fgColor;
  final Color? prefixColor;
  final Color? borderColor;
  final double? borderSize;
  final double? imageH;
  final bool isSmallText;
  final IconData? prefixIcon;
  final bool loading;
  final VoidCallback? onPressed;
  final String? prefixImage;
  final double? borderRadius;
  final double? height;
  final bool isDisabled;
  final double? width;
  final double? marginH;

  const GeneralTextButton({
    super.key,
    this.isSmallText = false,
    required this.title,
    this.isDisabled = false,
    this.borderSize,
    this.borderColor,
    this.loading = false,
    this.bgColor,
    this.fgColor,
    this.onPressed,
    this.borderRadius,
    this.height,
    this.width,
    this.marginH,
    this.prefixImage,
    this.prefixColor,
    this.imageH,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginH ?? AppSizes.padding),
      height: height ?? 38.h,
      width: width ?? MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor:
              WidgetStateProperty.all(bgColor ?? Colors.transparent),
          side: WidgetStateProperty.all<BorderSide>(
            BorderSide(
              color: borderColor ?? AppColors.buttonColor,
              width: borderSize ?? 1,
            ),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
            ),
          ),
        ),
        onPressed: (isDisabled || loading) ? null : onPressed,
        child: loading
            ? const CircularProgressIndicator(
                color: AppColors.primaryColor,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null)
                    Icon(
                      prefixIcon,
                      color: prefixColor,
                      size: imageH ?? 24,
                    ),
                  if (prefixImage != null)
                    Image.asset(
                      prefixImage!,
                      height: imageH ?? 24,
                      color: prefixColor,
                    ),
                  if (prefixImage != null || prefixIcon != null)
                    const SizedBox(
                      width: 5,
                    ),
                  Text(
                    title,
                    style: isSmallText
                        ? generalTextStyle(14).copyWith(
                            color: fgColor ?? AppColors.buttonColor,
                            fontWeight: FontWeight.w600)
                        : generalTextStyle(16).copyWith(
                            color: fgColor ?? AppColors.buttonColor,
                            fontWeight: FontWeight.w600),
                  ),
                ],
              ),
      ),
    );
  }
}
