import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/core/utils/show_toast.dart';
import 'package:kanban/core/values/routes_config.dart';
import 'package:kanban/presentation/bloc/section/section_task_bloc.dart';
import 'package:kanban/presentation/repositories/task_repository.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
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

  TaskBloc(this.taskRepository) : super(TaskInitialState()) {
    on<AddTaskEvent>((event, emit) async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      try {
        emit(TaskLoadingState());
        Map body = {
          "content": titleTEC.text,
          "description": descriptionTEC.text,
          "due_string": "${dueDateTEC.text} ${dueTimeTEC.text}",
          "priority": getPriority(priorityTEC.text),
          "section_id": event.sectionId,
          "due_lang": "en",
        };
        log(body.toString());
        await taskRepository.addTask(body);
        if (navKey.currentState!.mounted) {
          navKey.currentState?.context
              .read<SectionTaskBloc>()
              .add(FetchAllSectionsEvent(false));
          showToast("Task successfully added.");
          emit(ConcreteTaskSuccessState());
          navKey.currentState?.context.pop();
        }
      } on Exception catch (error) {
        showToast("Error occured while adding task.");
        emit(TaskErrorState(error.toString()));
      }
    });
    on<UpdateTaskEvent>((event, emit) async {
      if (!formKey.currentState!.validate()) {
        return;
      }
      try {
        emit(TaskLoadingState());
        Map body = {
          "content": titleTEC.text,
          "description": descriptionTEC.text,
          "due_string": "${dueDateTEC.text} ${dueTimeTEC.text}",
          "priority": getPriority(priorityTEC.text),
          "section_id": event.sectionId,
          "due_lang": "en",
        };
        log(body.toString());
        await taskRepository.updateTask(body, taskId: event.taskId);
        if (navKey.currentState!.mounted) {
          navKey.currentState?.context
              .read<SectionTaskBloc>()
              .add(FetchAllSectionsEvent(false));
          showToast("Task successfully updated.");
          navKey.currentState?.context.pop();
          emit(ConcreteTaskSuccessState());
        }
      } on Exception catch (error) {
        showToast("Error occured while adding task.");
        emit(TaskErrorState(error.toString()));
      }
    });
    on<LogTaskEvent>((event, emit) async {
      try {
        if (event.minute == 0) {
          return;
        }
        Map body = {
          "section_id": event.sectionId,
          "duration": event.minute,
          "duration_unit": "minute"
        };
        log(body.toString());
        await taskRepository.updateTask(body, taskId: event.taskId);
        if (navKey.currentState!.mounted) {
          navKey.currentState?.context
              .read<SectionTaskBloc>()
              .add(FetchAllSectionsEvent(false));
          showToast("Task time spent successfully saved.");
          // navKey.currentState?.context.pop();
        }
      } on Exception catch (_) {
        showToast("Error occured while logging task time spent.");
      }
    });
  }
}
