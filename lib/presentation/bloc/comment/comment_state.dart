part of 'comment_bloc.dart';

abstract class CommentEvent {}

class FetchAllCommentsEvent extends CommentEvent {
  final String taskId;
  FetchAllCommentsEvent({required this.taskId});
}

// states

sealed class CommentState {}

class CommentInitialState extends CommentState {}

class CommentLoadingState extends CommentState {}

abstract class CommentSuccessState extends CommentState {
  List<CommentModel> get comments;
}

class ConcreteCommentSuccessState implements CommentSuccessState {
  @override
  final List<CommentModel> comments;
  ConcreteCommentSuccessState(
    this.comments,
  );
}

class CommentErrorState extends CommentState {
  final String error;

  CommentErrorState(this.error);
}
