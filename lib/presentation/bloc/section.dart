import 'package:kanban/presentation/model/section_model.dart';

abstract class SectionEvent {}

class FetchAllSectionsEvent extends SectionEvent {}

// states.dart
abstract class SectionState {}

class SectionInitialState extends SectionState {}

class SectionLoadingState extends SectionState {}

abstract class SectionSuccessState extends SectionState {
  List<Section> get sections;
}

class ConcreteSectionsSuccessState implements SectionSuccessState {
  @override
  final List<Section> sections;
  ConcreteSectionsSuccessState(this.sections);
}

class SectionErrorState extends SectionState {
  final String error;

  SectionErrorState(this.error);
}
