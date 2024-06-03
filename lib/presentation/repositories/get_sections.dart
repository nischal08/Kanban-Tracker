import 'package:kanban/core/dio/dio_dependency_injection.dart';
import 'package:kanban/core/values/constants/app_urls.dart';
import 'package:kanban/core/values/enums.dart';
import 'package:kanban/presentation/models/section_model.dart';

abstract class SectionRepository {
  Future<List<Section>> call();
}

class GetAllSectionsRepository implements SectionRepository {
  @override
  Future<List<Section>> call() async {
    try {
      final response = await getApiClient().request(
        url: AppUrls.getAllSectionUrl,
        requestType: RequestType.getWithToken,
      );
      return (response as List)
          .map((section) => Section.fromJson(section))
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}
