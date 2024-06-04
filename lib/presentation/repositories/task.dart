import 'package:flutter/material.dart';
import 'package:kanban/core/dio/dio_dependency_injection.dart';
import 'package:kanban/core/values/constants/app_urls.dart';
import 'package:kanban/core/values/enums.dart';
import 'package:kanban/presentation/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> fetchAllTask(String sectionId);
  Future<TaskModel> addTask(Map body);
  Future<void> updateTask(Map body, {required String taskId});
  Future<void> deleteTask(String taskId);
}

class TasksRepositoryImpl extends TaskRepository {
  @override
  Future<List<TaskModel>> fetchAllTask(String sectionId) async {
    try {
      final response = await getApiClient().request(
        url: AppUrls.getSectionTasksUrl.replaceAll("[id]", sectionId),
        requestType: RequestType.getWithToken,
      );
      return (response as List)
          .map((item) => TaskModel.fromJson(item))
          .toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<TaskModel> addTask(Map body) async {
    try {
      final response = await getApiClient().request(
        url: AppUrls.addTaskUrl,
        requestType: RequestType.postWithToken,
        body: body,
      );
      return TaskModel.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateTask(Map body, {required String taskId}) async {
    try {
      await getApiClient().request(
        url: AppUrls.updateAndDeleteTaskUrl.replaceAll("[id]", taskId),
        requestType: RequestType.postWithToken,
        body: body,
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await getApiClient().request(
        url: AppUrls.updateAndDeleteTaskUrl.replaceAll("[id]", taskId),
        requestType: RequestType.deleteWithToken,
      );
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      rethrow;
    }
  }
}
