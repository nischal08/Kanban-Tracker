import 'package:get_it/get_it.dart';
import 'package:kanban/core/dio/api_manager.dart';

final getIt = GetIt.instance;

ApiManager getApiClient() => getIt.get<ApiManager>();

void setupApiManager() {
  getIt.registerSingleton<ApiManager>(ApiManager());
}
