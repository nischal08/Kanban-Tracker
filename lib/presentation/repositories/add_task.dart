import 'package:kanban/core/dio/dio_dependency_injection.dart';
import 'package:kanban/core/values/constants/app_urls.dart';
import 'package:kanban/core/values/enums.dart';

abstract class TaskRepository {
  Future<void> call(String sectionId);
}

class AddTaskRepository implements TaskRepository {
  @override
  Future<void> call(String sectionId) async {
    Map body = {
      "content": "Project setup (From API)",
      "description": "Project setup (From API) description",
      "due_string": "tomorrow at 12:00",
      "due_lang": "en",
      "priority": 4,
      "section_id": sectionId
    };
    try {
      await getApiClient().request(
        url: AppUrls.getSectionTasksUrl.replaceAll("[section_id]", sectionId),
        requestType: RequestType.getWithToken,
        body: body,
      );
    } catch (_) {
      rethrow;
    }
  }
}
