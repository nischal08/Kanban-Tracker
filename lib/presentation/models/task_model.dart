// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

TaskModel taskFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  final String id;
  final dynamic assignerId;
  final dynamic assigneeId;
  final String projectId;
  final String sectionId;
  final dynamic parentId;
  final int order;
  final String content;
  final String description;
  final bool isCompleted;
  final List<dynamic> labels;
  final int priority;
  final int commentCount;
  final String creatorId;
  final DateTime createdAt;
  final Due? due;
  final String url;
  final TaskDuration? duration;
  final Stopwatch stopwatch;

  TaskModel(
      {required this.id,
      required this.assignerId,
      required this.assigneeId,
      required this.projectId,
      required this.sectionId,
      required this.parentId,
      required this.order,
      required this.content,
      required this.description,
      required this.isCompleted,
      required this.labels,
      required this.priority,
      required this.commentCount,
      required this.creatorId,
      required this.createdAt,
      required this.due,
      required this.url,
      required this.duration,
      required this.stopwatch});

  TaskModel copyWith({
    String? id,
    dynamic assignerId,
    dynamic assigneeId,
    String? projectId,
    String? sectionId,
    dynamic parentId,
    int? order,
    String? content,
    String? description,
    bool? isCompleted,
    List<dynamic>? labels,
    int? priority,
    int? commentCount,
    String? creatorId,
    DateTime? createdAt,
    Due? due,
    String? url,
    TaskDuration? duration,
    Stopwatch? stopwatch,
  }) =>
      TaskModel(
        id: id ?? this.id,
        assignerId: assignerId ?? this.assignerId,
        assigneeId: assigneeId ?? this.assigneeId,
        projectId: projectId ?? this.projectId,
        sectionId: sectionId ?? this.sectionId,
        parentId: parentId ?? this.parentId,
        order: order ?? this.order,
        content: content ?? this.content,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
        labels: labels ?? this.labels,
        priority: priority ?? this.priority,
        commentCount: commentCount ?? this.commentCount,
        creatorId: creatorId ?? this.creatorId,
        createdAt: createdAt ?? this.createdAt,
        due: due ?? this.due,
        url: url ?? this.url,
        duration: duration ?? this.duration,
        stopwatch: stopwatch ?? this.stopwatch,
      );

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        assignerId: json["assigner_id"],
        assigneeId: json["assignee_id"],
        projectId: json["project_id"],
        sectionId: json["section_id"],
        parentId: json["parent_id"],
        order: json["order"],
        content: json["content"],
        description: json["description"],
        isCompleted: json["is_completed"],
        labels: List<dynamic>.from(json["labels"].map((x) => x)),
        priority: json["priority"],
        commentCount: json["comment_count"],
        creatorId: json["creator_id"],
        createdAt: DateTime.parse(json["created_at"]),
        due: json["due"] == null ? null : Due.fromJson(json["due"]),
        url: json["url"],
        stopwatch: Stopwatch(),
        duration: json["duration"] == null
            ? null
            : TaskDuration.fromJson(json["duration"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assigner_id": assignerId,
        "assignee_id": assigneeId,
        "project_id": projectId,
        "section_id": sectionId,
        "parent_id": parentId,
        "order": order,
        "content": content,
        "description": description,
        "is_completed": isCompleted,
        "labels": List<dynamic>.from(labels.map((x) => x)),
        "priority": priority,
        "comment_count": commentCount,
        "creator_id": creatorId,
        "created_at": createdAt.toIso8601String(),
        "due": due,
        "url": url,
        "duration": duration,
      };
}

class Due {
  final String date;
  final String string;
  final String lang;
  final bool isRecurring;
  final DateTime? datetime;

  Due({
    required this.date,
    required this.string,
    required this.lang,
    required this.isRecurring,
    required this.datetime,
  });

  Due copyWith({
    String? date,
    String? string,
    String? lang,
    bool? isRecurring,
    DateTime? datetime,
  }) =>
      Due(
        date: date ?? this.date,
        string: string ?? this.string,
        lang: lang ?? this.lang,
        isRecurring: isRecurring ?? this.isRecurring,
        datetime: datetime ?? this.datetime,
      );

  factory Due.fromJson(Map<String, dynamic> json) => Due(
        date: json["date"] ?? "",
        string: json["string"],
        lang: json["lang"],
        isRecurring: json["is_recurring"] ?? false,
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "string": string,
        "lang": lang,
        "is_recurring": isRecurring,
        "datetime": datetime!.toIso8601String(),
      };
}

class TaskDuration {
  final String amount;
  final String unit;

  TaskDuration({
    required this.amount,
    required this.unit,
  });

  TaskDuration copyWith({
    String? amount,
    String? unit,
  }) =>
      TaskDuration(
        amount: amount ?? this.amount,
        unit: unit ?? this.unit,
      );

  factory TaskDuration.fromJson(Map<String, dynamic> json) => TaskDuration(
        amount: json["amount"] == null ? "" : json["amount"].toString(),
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "unit": unit,
      };
}
