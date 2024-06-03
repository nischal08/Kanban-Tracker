import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/presentation/models/task_model.dart';
import 'package:kanban/presentation/repositories/get_tasks.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(TaskInitialState()) {
    on<FetchAllTasksEvent>((event, emit) async {
      emit(TaskLoadingState());
      try {
        final tasks = await taskRepository.call(event.sectionId);
        emit(ConcreteTaskSuccessState(tasks));
      } on Exception catch (error) {
        emit(TaskErrorState(error.toString()));
      }
    });
  }
}
