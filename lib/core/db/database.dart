import 'package:hive_flutter/hive_flutter.dart';

import '../../features/features.dart';

class HiveDatabase {
  HiveDatabase._internal();
  static final HiveDatabase _instance = HiveDatabase._internal();

  factory HiveDatabase() {
    return _instance;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AlarmAdapter());
    Hive.registerAdapter(TimerAdapter());
  }

  // Open a box
  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  Future<void> closeAllBoxes() async {
    await Hive.close();
  }

  Future<void> addData<T>(String boxName, T data) async {
    final box = await openBox<T>(boxName);
    await box.add(data);
  }

  Future<List<T>> getData<T>(String boxName) async {
    final box = await openBox<T>(boxName);
    return box.values.toList();
  }

  Future<void> deleteData<T>(String boxName, int index) async {
    final box = await openBox<T>(boxName);
    await box.deleteAt(index);
  }
}

// Global instance
final hiveDatabase = HiveDatabase();
