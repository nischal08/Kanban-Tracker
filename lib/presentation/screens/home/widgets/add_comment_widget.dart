import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/core/styles/app_sizes.dart';
import 'package:kanban/presentation/bloc/comment/add_comment_cubit.dart';
import 'package:kanban/presentation/bloc/task/task_bloc.dart';
import 'package:kanban/presentation/models/task_model.dart';
import 'package:kanban/presentation/protocols/is_empty_validation.dart';
import 'package:kanban/presentation/screens/home/widgets/custom_text.dart';
import 'package:kanban/presentation/widgets/general_elevated_button.dart';
import 'package:kanban/presentation/widgets/general_text_button.dart';
import 'package:kanban/presentation/widgets/general_textfield.dart';

class AddCommentWidget extends StatelessWidget {
  const AddCommentWidget({
    super.key,
    required this.addCommentBloc,
    required this.task,
  });
  final TaskModel task;
  final AddCommentCubit addCommentBloc;

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
      child: Form(
        key: addCommentBloc.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              text: "Add the comment",
              isTitle: true,
            ),
            gapH(20),
            const CustomText(text: "Comment"),
            gapH(4),
            GeneralTextField(
              hintText: "Write something",
              validate: (value) =>
                  IsEmptyValidation().validate(value, title: "comment."),
              controller: addCommentBloc.commentTEC,
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
                BlocBuilder<AddCommentCubit, AddCommentState>(builder: (_, state) {
                  return GeneralElevatedButton(
                    marginH: 0,
                    height: 32.h,
                    isMinimumWidth: true,
                    isSmallText: true,
                    title: "Add",
                    loading: state is TaskLoadingState,
                    borderRadius: 4.r,
                    onPressed: () {
                      context.read<AddCommentCubit>().addComment(task: task);
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
