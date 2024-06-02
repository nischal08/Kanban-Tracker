import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/core/repository/get_sections.dart';
import 'package:kanban/presentation/bloc/section.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  final SectionRepository sectionRepository;

  SectionBloc(this.sectionRepository) : super(SectionInitialState()) {
    on<FetchAllSectionsEvent>((event, emit) async {
        emit(SectionLoadingState());
        try {
          final sections = await sectionRepository.call();
          emit(ConcreteSectionsSuccessState(sections));
        } on Exception catch (error) {
          emit(SectionErrorState(error.toString()));
        }
    });
  }

  // Stream<SectionState> mapEventToState(SectionEvent event) async* {
  //   debugger();
  //   if (event is FetchAllSectionsEvent) {
  //     yield SectionLoadingState();
  //     try {
  //       final sections = await sectionRepository.call();
  //       yield ConcreteSectionsSuccessState(sections);
  //     } on Exception catch (error) {
  //       yield SectionErrorState(error.toString());
  //     }
  //   }
  // }
}
