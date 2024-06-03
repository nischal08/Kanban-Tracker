// To parse this JSON data, do
//
//     final section = sectionFromJson(jsonString);

import 'dart:convert';

Section sectionFromJson(String str) => Section.fromJson(json.decode(str));

String sectionToJson(Section data) => json.encode(data.toJson());

class Section {
  final String id;
  final String projectId;
  final int order;
  final String name;

  Section({
    required this.id,
    required this.projectId,
    required this.order,
    required this.name,
  });

  Section copyWith({
    String? id,
    String? projectId,
    int? order,
    String? name,
  }) =>
      Section(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        order: order ?? this.order,
        name: name ?? this.name,
      );

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        projectId: json["project_id"],
        order: json["order"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "order": order,
        "name": name,
      };
}
