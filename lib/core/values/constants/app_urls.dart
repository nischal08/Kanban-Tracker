class AppUrls {
  static const String baseUrl = "https://api.todoist.com/rest/v2";
  static const String getAllSectionUrl =
      "$baseUrl/sections?project_id=2334093161";
  static const String getSectionTasksUrl = "$baseUrl/tasks?section_id=[id]";
  static const String addTaskUrl = "$baseUrl/tasks";
  static const String updateAndDeleteTaskUrl = "$baseUrl/tasks/[id]";
  static const String closeTaskUrl = "$baseUrl/tasks/[id]/close";
  static const String getTaskCommentUrl = "$baseUrl/comments?task_id=[id]";
  static const String addTaskCommentUrl = "$baseUrl/comments";
}
