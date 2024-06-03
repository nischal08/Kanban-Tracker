import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:kanban/core/styles/app_sizes.dart';
import 'package:kanban/core/styles/text_styles.dart';
import 'package:kanban/presentation/widgets/general_elevated_button.dart';
import 'package:kanban/presentation/widgets/general_text_button.dart';
import 'package:kanban/presentation/widgets/general_textfield.dart';

class AddCardDialog extends StatefulWidget {
  const AddCardDialog({
    super.key,
  });

  @override
  State<AddCardDialog> createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<AddCardDialog> {
  final TextEditingController titleTEC = TextEditingController();
  final TextEditingController descriptionTEC = TextEditingController();
  final TextEditingController dueDateTEC = TextEditingController();
  final TextEditingController dueTimeTEC = TextEditingController();
  final addCardFormKey = GlobalKey<FormState>();
  DateTime lastDate = DateTime.now().add(const Duration(days: 365 * 18));
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
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
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: bodyContent(context),
      ),
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
      dueDateTEC.text = DateFormat("dd-MM-yyyy").format(selectedDate);
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
      dueTimeTEC.text =
          '${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name.toUpperCase()} ';
      setState(() {});
    }
  }

  Form bodyContent(BuildContext context) {
    return Form(
      key: addCardFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Create a task",
            textAlign: TextAlign.center,
            style: generalTextStyle(22).copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          gapH(20),
          Text(
            "Title",
            textAlign: TextAlign.center,
            style: generalTextStyle(12).copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          gapH(4),
          GeneralTextField(
            controller: titleTEC,
            validate: () {},
            textInputAction: TextInputAction.next,
            hintText: "Write something",
          ),
          gapH(16),
          Text(
            "Due Date",
            textAlign: TextAlign.center,
            style: generalTextStyle(12).copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          gapH(4),
          GeneralTextField(
            readonly: true,
            onTap: () => selectDate(context),
            hintText: "Select a date",
            controller: dueDateTEC,
            validate: () {},
            textInputAction: TextInputAction.next,
          ),
          gapH(16),
          Text(
            "Due Time",
            textAlign: TextAlign.center,
            style: generalTextStyle(12).copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          gapH(4),
          GeneralTextField(
            readonly: true,
            onTap: () => selectTime(context),
            hintText: "Select a time",
            controller: dueTimeTEC,
            validate: () {},
            textInputAction: TextInputAction.next,
          ),
          gapH(16),
          Text(
            "Description",
            textAlign: TextAlign.center,
            style: generalTextStyle(12).copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          gapH(4),
          GeneralTextField(
            hintText: "Write something",
            controller: descriptionTEC,
            validate: () {},
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
                  Navigator.of(context).pop();
                },
              ),
              gapW(8),
              GeneralElevatedButton(
                marginH: 0,
                height: 32.h,
                isMinimumWidth: true,
                isSmallText: true,
                title: "Create",
                borderRadius: 4.r,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
