import 'package:kanban/core/dio/dio_dependency_injection.dart';
import 'package:kanban/core/values/constants/app_urls.dart';
import 'package:kanban/core/values/enums.dart';
import 'package:kanban/presentation/models/comment_model.dart';

abstract class CommentRepository {
  Future<List<CommentModel>> fetchAllComment(String taskId);
  Future<CommentModel> addComment(Map body);
  // Future<void> updateTask(Map body, {required String taskId});
  // Future<void> deleteTask(String taskId);
}

class CommentRepositoryImpl extends CommentRepository {
  @override
  Future<List<CommentModel>> fetchAllComment(String taskId) async {
    try {
      final response = await getApiClient().request(
        url: AppUrls.getTaskCommentUrl.replaceAll("[id]", taskId),
        requestType: RequestType.getWithToken,
      );
      return (response as List)
          .map((item) => CommentModel.fromJson(item))
          .toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<CommentModel> addComment(Map body) async {
    try {
      final response = await getApiClient().request(
        url: AppUrls.addTaskCommentUrl,
        requestType: RequestType.postWithToken,
        body: body,
      );
      return CommentModel.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }

  // @override
  // Future<void> updateTask(Map body, {required String taskId}) async {
  //   try {
  //     await getApiClient().request(
  //       url: AppUrls.updateAndDeleteTaskUrl.replaceAll("[id]", taskId),
  //       requestType: RequestType.postWithToken,
  //       body: body,
  //     );
  //   } catch (_) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<void> deleteTask(String taskId) async {
  //   try {
  //     await getApiClient().request(
  //       url: AppUrls.updateAndDeleteTaskUrl.replaceAll("[id]", taskId),
  //       requestType: RequestType.deleteWithToken,
  //     );
  //   } catch (e, s) {
  //     debugPrint(e.toString());
  //     debugPrint(s.toString());
  //     rethrow;
  //   }
  // }
}
