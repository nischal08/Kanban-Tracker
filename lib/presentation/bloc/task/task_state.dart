part of 'add_task_bloc.dart';

abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String sectionId;
  AddTaskEvent(this.sectionId);
}
// states.dart
abstract class TaskState {}

class AddTaskInitialState extends TaskState {}

class AddTaskLoadingState extends TaskState {}

abstract class AddTaskSuccessState extends TaskState {}

class ConcreteAddTaskSuccessState implements AddTaskSuccessState {
  ConcreteAddTaskSuccessState();
}

class AddTaskErrorState extends TaskState {
  final String error;

  AddTaskErrorState(this.error);
}
