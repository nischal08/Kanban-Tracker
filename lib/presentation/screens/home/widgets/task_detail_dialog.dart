import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kanban/core/styles/styles.dart';
import 'package:kanban/core/utils/priority_util.dart';
import 'package:kanban/core/utils/time_util.dart';
import 'package:kanban/presentation/bloc/comment/add_comment_cubit.dart';
import 'package:kanban/presentation/bloc/comment/get_comment_bloc.dart';
import 'package:kanban/presentation/bloc/section/section_task_bloc.dart';
import 'package:kanban/presentation/bloc/task/delete_task.dart';
import 'package:kanban/presentation/bloc/task/move_task_cubit.dart';
import 'package:kanban/presentation/bloc/task/task_bloc.dart';
import 'package:kanban/presentation/models/task_model.dart';
import 'package:kanban/presentation/screens/home/widgets/add_and_edit_card_bottomsheet.dart';
import 'package:kanban/presentation/screens/home/widgets/add_comment_widget.dart';
import 'package:kanban/presentation/screens/home/widgets/comment_info_widget.dart';
import 'package:kanban/presentation/screens/home/widgets/task_info_column.dart';
import 'package:kanban/presentation/widgets/confirmation_dialog.dart';
import 'package:kanban/presentation/widgets/general_elevated_button.dart';
import 'package:kanban/presentation/widgets/general_text_button.dart';

class TaskDetailDialog extends StatefulWidget {
  final String sectionId;
  final String itemContent;
  final String taskStatus;
  const TaskDetailDialog({
    super.key,
    required this.sectionId,
    required this.taskStatus,
    required this.itemContent,
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

  late final AddCommentCubit addCommentBloc;
  @override
  void initState() {
    super.initState();
    addCommentBloc = context.read<AddCommentCubit>();
    if (context.read<SectionTaskBloc>().state is ConcreteSectionsSuccessState) {
      TaskModel task = (context.read<SectionTaskBloc>().state
              as ConcreteSectionsSuccessState)
          .tasks[widget.sectionId]!
          .firstWhere((element) {
        return widget.itemContent.contains(element.id);
      });
      context
          .read<GetCommentBloc>()
          .add(FetchAllCommentsEvent(taskId: task.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 120.h),
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
            child: BlocBuilder<SectionTaskBloc, SectionState>(
              builder: (_, state) {
                switch (state) {
                  case SectionLoadingState _:
                    return SizedBox(
                      height: 200.h,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case SectionErrorState _:
                    return SizedBox(
                      height: 200.h,
                      child: Center(
                        child: Text(state.error.toString()),
                      ),
                    );
                  case ConcreteSectionsSuccessState _:
                    TaskModel task =
                        state.tasks[widget.sectionId]!.firstWhere((element) {
                      return widget.itemContent.contains(element.id);
                    });
                    return bodyContent(context, task);
                  case SectionInitialState _:
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
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

  Widget bodyContent(BuildContext context, TaskModel task) {
    String createdDate =
        "${DateFormat().add_MMMEd().format(task.createdAt)}, ${DateFormat().addPattern("hh:mm a").format(task.createdAt)}";
    String dueDate = task.due?.datetime == null
        ? "N/A"
        : "${DateFormat().add_MMMEd().format(task.due!.datetime!)}, ${DateFormat().addPattern("hh:mm a").format(task.due!.datetime!)}";
    return SizedBox(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  task.content,
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
                            subTitle: task.id,
                          ),
                          gapH(12),
                          TaskInfoColumn(
                            title: "Priority",
                            subTitle: getPriorityText(task.priority),
                          ),
                          gapH(12),
                          TaskInfoColumn(
                            title: "Time spent",
                            subTitle: task.duration?.amount != null
                                ? convertMinutesToDHM(task.duration!.amount)
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
                            title: "Timer",
                            subTitle: elapsedTime,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                gapH(12),
                TaskInfoColumn(
                  title: "Description",
                  subTitle: task.description.isEmpty ? "N/A" : task.description,
                ),
                gapH(12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TaskInfoColumn(
                      title: "Comments",
                    ),
                    gapW(4),
                    GestureDetector(
                      onTap: () async {
                        await showModalBottomSheet(
                            context: context,
                            useSafeArea: true,
                            isScrollControlled: true,
                            builder: (BuildContext dgContext) {
                              return AddCommentWidget(
                                  task: task, addCommentBloc: addCommentBloc);
                            });
                      },
                      child: Icon(
                        Icons.add_circle_outline,
                        color: Colors.grey.shade600,
                        size: 15.h,
                      ),
                    )
                  ],
                ),
                BlocBuilder<GetCommentBloc, GetCommentState>(
                  builder: (_, state) {
                    switch (state) {
                      case GetCommentLoadingState _:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case GetCommentErrorState _:
                        return Center(
                          child: Text(
                            state.error,
                            style: generalTextStyle(14).copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      case GetCommentSuccessState _:
                        if (state.comments.isEmpty) {
                          return Text(
                            "No Comments!",
                            style: generalTextStyle(14).copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: state.comments
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(top: 6.h),
                                      child: CommentInfoWidget(e),
                                    ))
                                .toList());
                      case SectionInitialState _:
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
                if (task.sectionId != "157252879") gapH(55),
              ],
            ),
          ),
          if (task.sectionId != "157252879")
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlocBuilder<DeleteTaskCubit, TaskState>(
                      builder: (_, state) {
                        return IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 21.h,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          onPressed: () async {
                            bool continueProgram = (await showDialog(
                                    context: context,
                                    barrierColor: Colors.black.withOpacity(0.8),
                                    builder: (BuildContext dgContext) {
                                      return const ConfirmationDialog(
                                        title:
                                            "Do you sure want to delete the task?",
                                      );
                                    })) ??
                                false;
                            if (continueProgram && context.mounted) {
                              context
                                  .read<DeleteTaskCubit>()
                                  .deleteTask(task.id);
                            }
                          },
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () async {
                        bool? isSuccess = await showModalBottomSheet(
                            context: context,
                            useSafeArea: true,
                            isScrollControlled: true,
                            builder: (BuildContext dgContext) {
                              return AddAndEditCardBottomsheet(
                                groupId: task.sectionId,
                                task: task,
                                onCreate: () {
                                  context
                                      .read<SectionTaskBloc>()
                                      .boardController
                                      .scrollToBottom(task.sectionId);
                                },
                              );
                            });

                        if (isSuccess != null) {
                          if (isSuccess && context.mounted) {
                            context.pop();
                          }
                        }
                      },
                      icon: Icon(
                        Icons.edit_note,
                        size: 24.h,
                      ),
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
                            context.read<MoveTaskCubit>().movetask(task);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
