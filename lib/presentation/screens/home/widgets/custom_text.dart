import 'package:flutter/material.dart';
import 'package:kanban/core/styles/text_styles.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isTitle;
  final Color? color;
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.isTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: generalTextStyle(isTitle ? 22 : 12).copyWith(
        color: color ?? Colors.black,
        fontWeight: isTitle ? FontWeight.w500 : FontWeight.w600,
      ),
    );
  }
}
