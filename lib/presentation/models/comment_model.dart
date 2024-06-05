class CommentModel {
  final String id;
  final String taskId;
  final dynamic projectId;
  final String content;
  final DateTime postedAt;
  final dynamic attachment;

  CommentModel({
    required this.id,
    required this.taskId,
    required this.projectId,
    required this.content,
    required this.postedAt,
    required this.attachment,
  });

  CommentModel copyWith({
    String? id,
    String? taskId,
    dynamic projectId,
    String? content,
    DateTime? postedAt,
    dynamic attachment,
  }) =>
      CommentModel(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        projectId: projectId ?? this.projectId,
        content: content ?? this.content,
        postedAt: postedAt ?? this.postedAt,
        attachment: attachment ?? this.attachment,
      );

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        taskId: json["task_id"],
        projectId: json["project_id"],
        content: json["content"],
        postedAt: DateTime.parse(json["posted_at"]),
        attachment: json["attachment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task_id": taskId,
        "project_id": projectId,
        "content": content,
        "posted_at": postedAt.toIso8601String(),
        "attachment": attachment,
      };
}
