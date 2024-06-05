import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kanban/core/styles/app_sizes.dart';
import 'package:kanban/presentation/bloc/task/add_task_bloc.dart';
import 'package:kanban/presentation/protocols/is_empty_validation.dart';
import 'package:kanban/presentation/screens/home/widgets/custom_text.dart';
import 'package:kanban/presentation/widgets/general_dropdown.dart';
import 'package:kanban/presentation/widgets/general_elevated_button.dart';
import 'package:kanban/presentation/widgets/general_text_button.dart';
import 'package:kanban/presentation/widgets/general_textfield.dart';

class AddCardBottomsheetContent extends StatefulWidget {
  final VoidCallback onCreate;
  final String groupId;
  const AddCardBottomsheetContent({
    super.key,
    required this.onCreate,
    required this.groupId,
  });

  @override
  State<AddCardBottomsheetContent> createState() =>
      _AddCardBottomsheetContentState();
}

class _AddCardBottomsheetContentState extends State<AddCardBottomsheetContent> {
  DateTime lastDate = DateTime.now().add(const Duration(days: 365 * 18));
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  late final AddTaskBloc addTaskBloc;

  @override
  void initState() {
    super.initState();
    addTaskBloc = context.read<AddTaskBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 16.h + MediaQuery.of(context).viewInsets.bottom,
        top: 16.h,
        left: 16.h,
        right: 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: bodyContent(context),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920),
        lastDate: lastDate);
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      addTaskBloc.dueDateTEC.text =
          DateFormat("dd-MM-yyyy").format(selectedDate);
      setState(() {});
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      addTaskBloc.dueTimeTEC.text =
          '${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name.toUpperCase()} ';
      setState(() {});
    }
  }

  SingleChildScrollView bodyContent(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: context.watch<AddTaskBloc>().formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              text: "Create a task",
              isTitle: true,
            ),
            gapH(20),
            const CustomText(text: "Title"),
            gapH(4),
            GeneralTextField(
              controller: addTaskBloc.titleTEC,
              validate: (value) =>
                  IsEmptyValidation().validate(value, title: "title"),
              textInputAction: TextInputAction.next,
              hintText: "Write something",
            ),
            gapH(16),
            const CustomText(text: "Priority"),
            gapH(4),
            GeneralDropdownTextField(
              onChanged: (value) {
                addTaskBloc.priorityTEC.text = value;
              },
              validate: (value) =>
                  IsEmptyValidation().validate(value, title: "priority"),
              items: const [
                "Normal",
                "Medium",
                "High",
                "Urgent",
              ],
              // initialValue: "Normal",
            ),
            gapH(16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: "Due Date"),
                      gapH(4),
                      GeneralTextField(
                        readonly: true,
                        onTap: () => selectDate(context),
                        hintText: "Select a date",
                        validate: (value) => IsEmptyValidation()
                            .validate(value, title: "due date"),
                        controller: addTaskBloc.dueDateTEC,
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),
                gapW(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(text: "Due Time"),
                      gapH(4),
                      GeneralTextField(
                        readonly: true,
                        onTap: () => selectTime(context),
                        hintText: "Select a time",
                        validate: (value) => IsEmptyValidation()
                            .validate(value, title: "due time"),
                        controller: addTaskBloc.dueTimeTEC,
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            gapH(16),
            const CustomText(text: "Description"),
            gapH(4),
            GeneralTextField(
              hintText: "Write something",
              validate: (value) =>
                  IsEmptyValidation().validate(value, title: "description"),
              controller: addTaskBloc.descriptionTEC,
              textInputAction: TextInputAction.next,
              maxLines: 3,
            ),
            gapH(16),
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
                BlocBuilder<AddTaskBloc, TaskState>(builder: (_, state) {
                  return GeneralElevatedButton(
                    marginH: 0,
                    height: 32.h,
                    isMinimumWidth: true,
                    isSmallText: true,
                    title: "Create",
                    loading: state is TaskLoadingState,
                    borderRadius: 4.r,
                    onPressed: () {
                      context.read<AddTaskBloc>().add(
                            AddTaskEvent(widget.groupId),
                          );
                      // widget.onCreate();
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
