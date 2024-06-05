import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban/core/styles/app_sizes.dart';
import 'package:kanban/core/styles/text_styles.dart';

class TaskInfoColumn extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData? iconData;
  const TaskInfoColumn({
    super.key,
    required this.title,
    required this.subTitle,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: generalTextStyle(14).copyWith(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        gapH(4),
        Row(
          children: [
            if (iconData != null)
              Flexible(
                fit: FlexFit.loose,
                child: Icon(
                  Icons.schedule,
                  color: Colors.grey.shade600,
                  size: 15.h,
                ),
              ),
            if (iconData != null) gapW(4),
            Expanded(
              flex: 10,
              child: Text(
                subTitle,
                style: generalTextStyle(14).copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
