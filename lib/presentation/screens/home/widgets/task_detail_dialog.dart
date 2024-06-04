import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/core/styles/styles.dart';
import 'package:kanban/presentation/models/task_model.dart';
import 'package:kanban/presentation/screens/home/widgets/custom_text.dart';
import 'package:kanban/presentation/widgets/general_text_button.dart';

class TaskDetailDialog extends StatelessWidget {
  final TaskModel task;
  final String taskStatus;
  const TaskDetailDialog({
    super.key,
    required this.task,
    required this.taskStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(
          16.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: bodyContent(context),
      ),
    );
  }

  Column bodyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              "Status",
              style: generalTextStyle(12).copyWith(
                color: Colors.grey,
              ),
            ),
            gapW(2.w),
            Text(
              taskStatus,
              style: generalTextStyle(12).copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const CustomText(
          text: "Task Detail",
          isTitle: true,
        ),
        gapH(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GeneralTextButton(
              height: 32.h,
              title: "Cancel",
              borderRadius: 4.r,
              fgColor: Colors.black,
              isMinimumWidth: true,
              isSmallText: true,
              bgColor: Colors.transparent,
              onPressed: () {
                context.pop();
              },
            ),
            gapW(8),
            // BlocBuilder<AddTaskBloc, TaskState>(
            //   builder: (_, state) {
            //     return GeneralElevatedButton(
            //       marginH: 0,
            //       height: 32.h,
            //       isMinimumWidth: true,
            //       isSmallText: true,
            //       title: "Create",
            //       loading: state is AddTaskLoadingState,
            //       borderRadius: 4.r,
            //       onPressed: () {
            //         context.read<AddTaskBloc>().add(
            //               AddTaskEvent(widget.groupId),
            //             );
            //         // widget.onCreate();
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ],
    );
  }
}
