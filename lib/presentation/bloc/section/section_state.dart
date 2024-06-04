part of 'section_task_bloc.dart';

abstract class SectionEvent {}

class FetchAllSectionsEvent extends SectionEvent {}

// states.dart

sealed class SectionState {}

class SectionInitialState extends SectionState {}

class SectionLoadingState extends SectionState {}

abstract class SectionSuccessState extends SectionState {
  List<Section> get sections;
  Map<String,List<TaskModel>> get tasks;
}

class ConcreteSectionsSuccessState implements SectionSuccessState {
  @override
  final List<Section> sections;
  @override
  final Map<String, List<TaskModel>> tasks;
  ConcreteSectionsSuccessState(this.sections, this.tasks);
}

class SectionErrorState extends SectionState {
  final String error;

  SectionErrorState(this.error);
}
