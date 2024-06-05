part of 'task_bloc.dart';

abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String sectionId;
  AddTaskEvent(this.sectionId);
}

class UpdateTaskEvent extends TaskEvent {
  final String sectionId;
  final String taskId;
  UpdateTaskEvent({required this.sectionId, required this.taskId});
}

// states.dart
abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

abstract class TaskSuccessState extends TaskState {}

class ConcreteTaskSuccessState implements TaskSuccessState {
  ConcreteTaskSuccessState();
}

class TaskErrorState extends TaskState {
  final String error;

  TaskErrorState(this.error);
}
