import 'package:kanban/core/dio/dio_dependency_injection.dart';
import 'package:kanban/core/values/constants/app_urls.dart';
import 'package:kanban/core/values/enums.dart';
import 'package:kanban/presentation/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> call(String sectionId);
}

class GetAllTasksRepository implements TaskRepository {
  @override
  Future<List<TaskModel>> call(String sectionId) async {
    try {
      final response = await getApiClient().request(
        url: AppUrls.getSectionTasksUrl.replaceAll("[section_id]", sectionId),
        requestType: RequestType.getWithToken,
      );
      return (response as List)
          .map((item) => TaskModel.fromJson(item))
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}
