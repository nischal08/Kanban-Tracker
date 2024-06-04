import 'package:kanban/core/dio/dio_dependency_injection.dart';
import 'package:kanban/core/values/constants/app_urls.dart';
import 'package:kanban/core/values/enums.dart';
import 'package:kanban/presentation/models/task_model.dart';

abstract class TaskAddRepository {
  Future<TaskModel> addTask(
    Map body,
  );
}

class AddTaskRepository implements TaskAddRepository {
  @override
  Future<TaskModel> addTask(Map body) async {
    try {
      final response = await getApiClient().request(
        url: AppUrls.addTasksUrl,
        requestType: RequestType.postWithToken,
        body: body,
      );
      return TaskModel.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }
}
