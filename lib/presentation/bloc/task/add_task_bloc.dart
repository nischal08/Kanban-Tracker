import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/core/utils/show_toast.dart';
import 'package:kanban/core/values/routes_config.dart';
import 'package:kanban/presentation/bloc/section/section_task_bloc.dart';
import 'package:kanban/presentation/repositories/task.dart';
part 'task_state.dart';

class AddTaskBloc extends Bloc<TaskEvent, TaskState> {
  final TasksRepositoryImpl taskRepository;
  final TextEditingController titleTEC = TextEditingController();
  final TextEditingController descriptionTEC = TextEditingController();
  final TextEditingController dueDateTEC = TextEditingController();
  final TextEditingController dueTimeTEC = TextEditingController();
  final TextEditingController priorityTEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  int getPriority(String value) {
    switch (value) {
      case "Urgent":
        return 4;
      case "High":
        return 3;
      case "Medium":
        return 2;
      case "Normal":
        return 1;
      default:
        return 1;
    }
  }

  AddTaskBloc(this.taskRepository) : super(TaskInitialState()) {
    on<AddTaskEvent>((event, emit) async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      try {
        emit(TaskLoadingState());
        Map body = {
          "content": descriptionTEC.text,
          "description": titleTEC.text,
          "due_string": "${dueDateTEC.text} ${dueTimeTEC.text}",
          "priority": getPriority(priorityTEC.text),
          "section_id": event.sectionId,
          "due_lang": "en",
        };
        log(body.toString());
        await taskRepository.addTask(body);
        navKey.currentState?.context
            .read<SectionTaskBloc>()
            .add(FetchAllSectionsEvent());
        showToast("Task successfully added.");
        emit(ConcreteTaskSuccessState());
        navKey.currentState?.context.pop();
      } on Exception catch (error) {
        showToast("Error occured while adding task.");
        emit(TaskErrorState(error.toString()));
      }
    });
  }
}
