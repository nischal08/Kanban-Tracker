part of "add_comment_cubit.dart";

sealed class AddCommentState {}

class AddCommentInitialState extends AddCommentState {}

class AddCommentLoadingState extends AddCommentState {}

abstract class AddCommentSuccessState extends AddCommentState {
  CommentModel get comment;
}

class ConcreteAddCommentSuccessState implements AddCommentSuccessState {
  @override
  final CommentModel comment;
  ConcreteAddCommentSuccessState(
    this.comment,
  );
}

class AddCommentErrorState extends AddCommentState {
  final String error;

  AddCommentErrorState(this.error);
}
