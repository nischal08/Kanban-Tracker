import 'package:kanban/core/database/hive_database_helper.dart';
import 'package:kanban/core/values/constants/database_constants.dart';

class DatabaseHelperProvider {
  Future<void> saveToken(String accessToken) async {
    await DatabaseHelper().addBoxItem(
      key: DatabaseKey.accessToken,
      value: accessToken.toString(),
      boxId: DatabaseBoxId.auth,
    );
  }

  Future<String> getToken() async {
    final String? accessToken = await DatabaseHelper().getBoxItem(
      key: DatabaseKey.accessToken,
      boxId: DatabaseBoxId.auth,
    );

    return accessToken??"";
  }

  Future<bool> deleteAccessToken() async {
    await DatabaseHelper().deleteBoxItem(
      key: DatabaseKey.accessToken,
      boxId: DatabaseBoxId.auth,
    );
    return true;
  }
}
