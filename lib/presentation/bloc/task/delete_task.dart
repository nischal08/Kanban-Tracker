import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/core/values/routes_config.dart';
import 'package:kanban/presentation/bloc/section/section_task_bloc.dart';
import 'package:kanban/presentation/bloc/task/add_task_bloc.dart';
import 'package:kanban/presentation/repositories/task.dart';

class DeleteTaskCubit extends Cubit<TaskState> {
  final TaskRepository taskRepository;
  DeleteTaskCubit(this.taskRepository) : super(TaskInitialState());

  deleteTask(String id) async {
    try {
      emit(TaskLoadingState());
      await taskRepository.deleteTask(id);
      if (navKey.currentState!.context.mounted) {
        navKey.currentState!.context
            .read<SectionTaskBloc>()
            .add(FetchAllSectionsEvent());
        emit(ConcreteTaskSuccessState());
        navKey.currentState!.context.pop();
      }
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }
}
