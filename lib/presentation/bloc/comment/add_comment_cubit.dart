import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/core/values/routes_config.dart';
import 'package:kanban/presentation/bloc/comment/get_comment_bloc.dart';
import 'package:kanban/presentation/models/comment_model.dart';
import 'package:kanban/presentation/models/task_model.dart';
import 'package:kanban/presentation/repositories/comment_repository.dart';

part "add_comment_state.dart";

class AddCommentCubit extends Cubit<AddCommentState> {
  final CommentRepository taskRepository;
  AddCommentCubit(this.taskRepository) : super(AddCommentInitialState());
  final TextEditingController commentTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  addComment({required TaskModel task}) async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      emit(AddCommentLoadingState());
      Map body = {"task_id": task.id, "content": commentTEC.text};
      CommentModel comment = await taskRepository.addComment(body);
      if (navKey.currentState!.mounted) {
        navKey.currentState!.context.read<GetCommentBloc>().add(
              FetchAllCommentsEvent(taskId: task.id),
            );
        emit(ConcreteAddCommentSuccessState(comment));
        navKey.currentState!.context.pop();
      }
    } catch (e) {
      emit(AddCommentErrorState(e.toString()));
    }
  }
}
