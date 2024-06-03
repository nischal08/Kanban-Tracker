part of 'task_bloc.dart';

sealed class TaskEvent {}

class FetchAllTasksEvent extends TaskEvent {
  final String sectionId;
  FetchAllTasksEvent(this.sectionId);
}

// states.dart
abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

abstract class TaskSuccessState extends TaskState {
  List<TaskModel> get sections;
}

class ConcreteTaskSuccessState implements TaskSuccessState {
  @override
  final List<TaskModel> sections;
  ConcreteTaskSuccessState(this.sections);
}

class TaskErrorState extends TaskState {
  final String error;

  TaskErrorState(this.error);
}
