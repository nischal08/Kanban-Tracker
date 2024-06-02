import 'package:hive/hive.dart';

class DatabaseHelper {
  deleteBoxItem({
    required String key,
    required String boxId,
  }) async {
    var box = await Hive.openBox(boxId);
    box.delete(key);
  }

  addBoxItem({
    required String key,
    required dynamic value,
    required String boxId,
  }) async {
    var box = await Hive.openBox(boxId);
    box.put(key, value);
  }

  dynamic getBoxItem({
    required String key,
    required String boxId,
  }) async {
    var box = await Hive.openBox(boxId);
    return box.get(key, defaultValue: null);
  }
}
