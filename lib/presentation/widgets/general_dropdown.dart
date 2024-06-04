import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban/core/styles/app_colors.dart';
import 'package:kanban/core/styles/text_styles.dart';

class GeneralDropdownTextField extends StatefulWidget {
  final String? initialValue;
  final List<String> items;
  final Function(String) validate;
  final String? labelText;
  final void Function(String) onChanged;

  const GeneralDropdownTextField({
    super.key,
    this.initialValue,
    required this.items,
    required this.validate,
    required this.onChanged,
    this.labelText,
  });

  @override
  GeneralDropdownTextFieldState createState() =>
      GeneralDropdownTextFieldState();
}

class GeneralDropdownTextFieldState extends State<GeneralDropdownTextField> {
  String? _currentValue = '';

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      hint: widget.labelText == null
          ? null
          : Text(
              widget.labelText!,
              style: generalTextStyle(14.sp),
            ),
      value: _currentValue,
      isExpanded: false,
      style: generalTextStyle(14),
      decoration: InputDecoration(
        counterText: "",
        fillColor: AppColors.textFieldInputColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.textfieldBorderColor),
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.textfieldBorderColor),
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.textfieldBorderColor),
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
        hintStyle: generalTextStyle(14.sp),
        prefixIconConstraints: const BoxConstraints(
          minHeight: 0,
          minWidth: 0,
        ),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error, // or any other color
        ),
        contentPadding: EdgeInsets.only(
          top: 0.h,
          right: 10.r,
          left: 10.r,
        ),
      ),
      validator: (value) {
        return widget.validate(value ?? "");
      },
      onChanged: (String? newValue) {
        if (newValue != null) {
          _currentValue = newValue;
          widget.onChanged(_currentValue!);
          setState(() {});
        }
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
