abstract class AppState<T> {}

class InitialState<T> extends AppState {
  final T? data;
  final T? message;
  InitialState({this.data, this.message});

  List<Object?> get props => [data, message];
}

class LoadingState<T> extends AppState {
  final T? data;
  final T? message;
  LoadingState({this.data, this.message});

  List<Object?> get props => [data, message];
}

class CompletedState<T> extends AppState {
  final T data;
  final String? message;

  CompletedState({
    required this.data,
    this.message,
  });

  List<Object?> get props => [data, message];
}

class ErrorState<T> extends AppState {
  final T? data;
  final String message;

  ErrorState({
    this.data,
    required this.message,
  });

  List<Object?> get props => [message];
}
