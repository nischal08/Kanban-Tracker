part of 'get_comment_bloc.dart';

abstract class CommentEvent {}

class FetchAllCommentsEvent extends CommentEvent {
  final String taskId;
  FetchAllCommentsEvent({required this.taskId});
}

// states

sealed class GetCommentState {}

class GetCommentInitialState extends GetCommentState {}

class GetCommentLoadingState extends GetCommentState {}

abstract class GetCommentSuccessState extends GetCommentState {
  List<CommentModel> get comments;
}

class ConcreteGetCommentSuccessState implements GetCommentSuccessState {
  @override
  final List<CommentModel> comments;
  ConcreteGetCommentSuccessState(
    this.comments,
  );
}

class GetCommentErrorState extends GetCommentState {
  final String error;

  GetCommentErrorState(this.error);
}
