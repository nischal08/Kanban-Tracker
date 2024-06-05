import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/core/values/routes_config.dart';
import 'package:kanban/presentation/bloc/section/section_task_bloc.dart';
import 'package:kanban/presentation/bloc/task/task_bloc.dart';
import 'package:kanban/presentation/models/task_model.dart';
import 'package:kanban/presentation/repositories/task_repository.dart';

class MoveTaskCubit extends Cubit<TaskState> {
  final TaskRepository taskRepository;
  MoveTaskCubit(this.taskRepository) : super(TaskInitialState());

  movetask(TaskModel task) async {
    try {
      emit(TaskLoadingState());
      Map body = {
        "content": task.content,
        "description": task.description,
        if (task.due != null) "due_string": task.due!.string,
        "priority": task.priority,
        "section_id": "157252879",
        "due_lang": "en",
      };
      await taskRepository.deleteTask(task.id);
      await taskRepository.addTask(body);
      if (navKey.currentState!.mounted) {
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
