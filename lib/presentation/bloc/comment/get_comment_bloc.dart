import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/presentation/models/comment_model.dart';
import 'package:kanban/presentation/repositories/comment_repository.dart';

part 'get_comment_state.dart';

class GetCommentBloc extends Bloc<CommentEvent, GetCommentState> {
  final CommentRepository sectionRepository;

  GetCommentBloc(this.sectionRepository) : super(GetCommentInitialState()) {
    on<FetchAllCommentsEvent>((event, emit) async {
      emit(GetCommentLoadingState());
      try {
        final comments = await sectionRepository.fetchAllComment(event.taskId);
        // debugger();
        emit(ConcreteGetCommentSuccessState(comments));
      } catch (error, stacktrace) {
        log(stacktrace.toString());
        emit(GetCommentErrorState(error.toString()));
      }
    });
  }
}
