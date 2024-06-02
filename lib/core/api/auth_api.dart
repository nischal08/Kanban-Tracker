import 'dart:developer';

import 'package:kanban/core/api/api_manager.dart';
import 'package:kanban/core/values/constants/app_urls.dart';
import 'package:kanban/core/values/enums.dart';

class AuthApi {
  final ApiManager _apiManager = ApiManager();

  Future<dynamic> login(dynamic data) async {
    try {
      final response = await _apiManager.request(
          url: AppUrls.loginUrl, body: data, requestType: RequestType.post);
      return response;
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

}
