import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalStorage {
  const LocalStorage();

  void open();

  static Future<void> init([
    String? subDir,
  ]) async {
    await Hive.initFlutter(subDir);
  }
}
