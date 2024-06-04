import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban/core/styles/app_colors.dart';
import 'package:kanban/core/styles/app_sizes.dart';
import 'package:kanban/core/styles/text_styles.dart';

class GeneralTextField extends StatefulWidget {
  final String? labelText;
  final String? suffixText;
  final String? hintText;
  final Color? labelTextColor;
  final bool isSmallText;
  final bool isTextArea;
  final bool isDisabled;
  final bool isHintTextBig;
  final IconData? suffixIcon;
  final Widget? prefixWidget;
  final Widget? sufixWidget;
  final bool obscureText;
  final bool removePrefixIconDivider;
  final VoidCallback? onClickPsToggle;
  final VoidCallback? onTap;
  final TextInputType keywordType;
  final Function validate;
  final Function? onFieldSubmit;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final Function? onSave;
  final Function? onChanged;
  final TextEditingController? controller;
  final bool readonly;
  final int? maxLength;
  final int? maxLines;
  final double? borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final Color? suffixIconColor;
  final Iterable<String>? autoFillHints;
  final bool autofocus;
  final bool removeRightBorder;
  final bool centerText;
  final bool isNumber;
  final Color? hintColor;
  // is number

  const GeneralTextField({
    super.key,
    this.labelText,
    this.isHintTextBig = false,
    this.labelTextColor,
    this.suffixIcon,
    this.maxLines,
    this.borderRadius,
    this.prefixWidget,
    this.sufixWidget,
    this.suffixText,
    this.obscureText = false,
    this.onClickPsToggle,
    this.keywordType = TextInputType.text,
    required this.validate,
    this.onFieldSubmit,
    required this.textInputAction,
    this.readonly = false,
    this.focusNode,
    this.onSave,
    this.controller,
    this.onChanged,
    this.removePrefixIconDivider = false,
    this.isSmallText = false,
    this.autofocus = false,
    this.maxLength,
    this.hintText,
    this.fillColor,
    this.borderColor,
    this.onTap,
    this.centerText = false,
    this.suffixIconColor,
    this.autoFillHints,
    this.isDisabled = false,
    this.hintColor,
    this.isNumber = false,
    this.isTextArea = false,
    this.removeRightBorder = false,
  });

  @override
  GeneralTextFieldState createState() => GeneralTextFieldState();
}

class GeneralTextFieldState extends State<GeneralTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        maxLines: widget.maxLines ?? 1,
        enabled: !widget.isDisabled,
        textAlign: widget.centerText ? TextAlign.center : TextAlign.start,
        autofocus: widget.autofocus,
        onChanged: (newValue) {
          if (widget.onChanged != null) widget.onChanged!(newValue);
        },
        controller: widget.controller,
        onSaved: (newValue) {
          if (widget.onSave != null) widget.onSave!(newValue);
        },
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: (newValue) {
          if (widget.onFieldSubmit != null) widget.onFieldSubmit!(newValue);
        },
        validator: (value) => widget.validate(value),
        keyboardType: widget.keywordType,
        readOnly: widget.readonly,
        onTap: widget.onTap,
        autofillHints: widget.autoFillHints,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
          FilteringTextInputFormatter.deny(
            RegExp(
                r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
          ),
          LengthLimitingTextInputFormatter(widget.maxLength),
          if (widget.isNumber)
            FilteringTextInputFormatter.allow(
              RegExp(r'[\d.\d]+$'),
            )
        ],
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: widget.isSmallText ? 0 : 18.h,
            left: widget.prefixWidget == null ? AppSizes.padding * 1.5 : 0,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: widget.removeRightBorder
                ? BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius ?? 8.r),
                    bottomLeft: Radius.circular(widget.borderRadius ?? 8.r),
                  )
                : BorderRadius.circular(widget.borderRadius ?? 8.r),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: widget.removeRightBorder
                ? BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius ?? 8.r),
                    bottomLeft: Radius.circular(widget.borderRadius ?? 8.r),
                  )
                : BorderRadius.circular(widget.borderRadius ?? 8.r),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1,
            ),
          ),
          errorMaxLines: 3,
          labelText: widget.labelText,
          labelStyle:
              generalTextStyle(widget.isSmallText ? 10 : 12).copyWith(
            color: widget.labelTextColor ?? AppColors.textSoftGreyColor,
            fontWeight: FontWeight.w400,
          ),
          hintText: widget.hintText,
          hintStyle: generalTextStyle(widget.isHintTextBig
                  ? 14
                  : widget.isSmallText
                      ? 10
                      : 12)
              .copyWith(
            color: widget.hintColor ?? AppColors.textSoftGreyColor,
            fontWeight:
                widget.isHintTextBig ? FontWeight.w600 : FontWeight.w400,
          ),
          suffixText: widget.suffixText,
          suffixStyle: generalTextStyle(widget.isSmallText ? 12 : 14).copyWith(
            color: AppColors.textSoftGreyColor,
          ),
          suffixIcon: widget.sufixWidget ??
              (widget.suffixText != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 14, right: AppSizes.padding),
                      child: Text(
                        widget.suffixText!,
                        style: const TextStyle(
                          color: AppColors.textSoftGreyColor,
                        ),
                      ),
                    )
                  : widget.suffixIcon != null
                      ? IconButton(
                          onPressed: widget.onClickPsToggle,
                          icon: Icon(
                            widget.suffixIcon,
                            color:
                                widget.suffixIconColor ?? Colors.grey.shade400,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                        )
                      : null),
          prefixIcon: widget.prefixWidget == null
              ? null
              : widget.removePrefixIconDivider
                  ? widget.prefixWidget
                  : SizedBox(
                      width: 125,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.prefixWidget!,
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
          focusedBorder: OutlineInputBorder(
            borderRadius: widget.removeRightBorder
                ? BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius ?? 8.r),
                    bottomLeft: Radius.circular(widget.borderRadius ?? 8.r),
                  )
                : BorderRadius.circular(widget.borderRadius ?? AppSizes.radius),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.primaryColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.removeRightBorder
                ? BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius ?? 8.r),
                    bottomLeft: Radius.circular(widget.borderRadius ?? 8.r),
                  )
                : BorderRadius.circular(widget.borderRadius ?? AppSizes.radius),
            borderSide: BorderSide(
              width: 1,
              color: widget.borderColor ?? AppColors.textfieldBorderColor,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: widget.removeRightBorder
                ? BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius ?? 8.r),
                    bottomLeft: Radius.circular(widget.borderRadius ?? 8.r),
                  )
                : BorderRadius.circular(widget.borderRadius ?? AppSizes.radius),
            borderSide: const BorderSide(
                width: 1, color: AppColors.textfieldBorderColor),
          ),
          fillColor: widget.fillColor ?? AppColors.textFieldInputColor,
          filled: true,
          errorStyle: TextStyle(
            color: Theme.of(context).colorScheme.error, // or any other color
          ),
        ),
      ),
    );
  }
}
