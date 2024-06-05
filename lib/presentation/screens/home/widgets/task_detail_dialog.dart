import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kanban/core/styles/styles.dart';
import 'package:kanban/core/utils/priority_util.dart';
import 'package:kanban/core/utils/time_util.dart';
import 'package:kanban/presentation/bloc/task/add_task_bloc.dart';
import 'package:kanban/presentation/bloc/task/delete_task.dart';
import 'package:kanban/presentation/bloc/task/move_task_cubit.dart';
import 'package:kanban/presentation/models/task_model.dart';
import 'package:kanban/presentation/screens/home/widgets/task_info_column.dart';
import 'package:kanban/presentation/widgets/confirmation_dialog.dart';
import 'package:kanban/presentation/widgets/general_elevated_button.dart';
import 'package:kanban/presentation/widgets/general_text_button.dart';

class TaskDetailDialog extends StatefulWidget {
  final TaskModel task;
  final String taskStatus;
  const TaskDetailDialog({
    super.key,
    required this.task,
    required this.taskStatus,
  });

  @override
  State<TaskDetailDialog> createState() => _TaskDetailDialogState();
}

class _TaskDetailDialogState extends State<TaskDetailDialog> {
  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool isStarted = false;
  String elapsedTime = '00:00:00.00';

  void updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  String transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds ~/ 10) % 100;
    int seconds = milliseconds ~/ 1000 % 60;
    int minutes = milliseconds ~/ 60000 % 60;
    int hours = milliseconds ~/ 3600000;
    String hourString =
        hours != 0 ? '${hours.toString().padLeft(2, '0')}:' : '';
    String minuteString = '${minutes.toString().padLeft(2, '0')}:';
    String secondString = '${seconds.toString().padLeft(2, '0')}.';
    String hundredthString = hundreds.toString().padLeft(2, '0');
    return '$hourString$minuteString$secondString$hundredthString';
  }

  void startWatch() {
    setState(() {
      isStarted = true;
      watch.start();
      timer = Timer.periodic(const Duration(milliseconds: 100), updateTime);
    });
  }

  void stopWatch() {
    setState(() {
      isStarted = false;
      watch.stop();
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(
              16.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: bodyContent(context),
          ),
          Positioned(
            top: 2.h,
            right: 2.h,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.close,
                size: 20.h,
              ),
            ),
          )
        ],
      ),
    );
  }

  Column bodyContent(BuildContext context) {
    String createdDate =
        "${DateFormat().add_MMMEd().format(widget.task.createdAt)}, ${DateFormat().addPattern("hh:mm a").format(widget.task.createdAt)}";
    String dueDate = widget.task.due?.datetime == null
        ? "N/A"
        : "${DateFormat().add_MMMEd().format(widget.task.due!.datetime!)}, ${DateFormat().addPattern("hh:mm a").format(widget.task.due!.datetime!)}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              "Status",
              style: generalTextStyle(12).copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            gapW(2.w),
            Text(
              widget.taskStatus,
              style: generalTextStyle(12).copyWith(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          widget.task.content,
          style: generalTextStyle(18).copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        gapH(24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskInfoColumn(
                    title: "Task ID",
                    subTitle: widget.task.id,
                  ),
                  gapH(12),
                  TaskInfoColumn(
                    title: "Priority",
                    subTitle: getPriorityText(widget.task.priority),
                  ),
                  gapH(12),
                  TaskInfoColumn(
                    title: "Time spent",
                    subTitle: widget.task.duration?.amount != null
                        ? convertMinutesToDHM(widget.task.duration!.amount)
                        : "N/A",
                  ),
                ],
              ),
            ),
            gapW(16),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskInfoColumn(
                    title: "Due Date",
                    subTitle: dueDate,
                    iconData: Icons.schedule,
                  ),
                  gapH(12),
                  TaskInfoColumn(
                    title: "Created Date",
                    subTitle: createdDate,
                    iconData: Icons.schedule,
                  ),
                  gapH(12),
                  TaskInfoColumn(
                    title: "Description",
                    subTitle: widget.task.description.isEmpty
                        ? "N/A"
                        : widget.task.description,
                  ),
                ],
              ),
            ),
          ],
        ),
        gapH(24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlocBuilder<DeleteTaskCubit, TaskState>(
              builder: (_, state) {
                return GeneralElevatedButton(
                  marginH: 0,
                  height: 32.h,
                  isMinimumWidth: true,
                  isSmallText: true,
                  title: "Delete",
                  loading: state is TaskLoadingState,
                  borderRadius: 4.r,
                  bgColor: Theme.of(context).colorScheme.error,
                  onPressed: () async {
                    bool continueProgram = (await showDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.8),
                            builder: (BuildContext dgContext) {
                              return const ConfirmationDialog(
                                title: "Do you sure want to delete the task?",
                              );
                            })) ??
                        false;
                    if (continueProgram && context.mounted) {
                      context
                          .read<DeleteTaskCubit>()
                          .deleteTask(widget.task.id);
                    }
                  },
                );
              },
            ),
            const Spacer(),
            GeneralTextButton(
              height: 32.h,
              title: isStarted ? "Stop" : "Start",
              borderRadius: 4.r,
              fgColor: Colors.black,
              isMinimumWidth: true,
              isSmallText: true,
              bgColor: Colors.transparent,
              onPressed: () {
                if (isStarted) {
                  stopWatch();
                } else {
                  startWatch();
                }
              },
            ),
            gapW(4),
            BlocBuilder<MoveTaskCubit, TaskState>(
              builder: (_, state) {
                return GeneralElevatedButton(
                  marginH: 0,
                  height: 32.h,
                  isMinimumWidth: true,
                  isSmallText: true,
                  title: "Finished",
                  loading: state is TaskLoadingState,
                  borderRadius: 4.r,
                  onPressed: () {
                    context.read<MoveTaskCubit>().movetask(widget.task);
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
