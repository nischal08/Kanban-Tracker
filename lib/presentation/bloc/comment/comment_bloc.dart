import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/presentation/models/comment_model.dart';
import 'package:kanban/presentation/repositories/comment_repository.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository sectionRepository;

  CommentBloc(this.sectionRepository) : super(CommentInitialState()) {
    on<FetchAllCommentsEvent>((event, emit) async {
      emit(CommentLoadingState());
      try {
        final comments = await sectionRepository.fetchAllComment(event.taskId);
        // debugger();
        emit(ConcreteCommentSuccessState(comments));
      } catch (error, stacktrace) {
        log(stacktrace.toString());
        emit(CommentErrorState(error.toString()));
      }
    });
  }
}
