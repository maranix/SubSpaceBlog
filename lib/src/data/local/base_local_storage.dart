import 'package:hive_flutter/hive_flutter.dart';

/// An abstract base class for local storage.
abstract class LocalStorage {
  /// Creates a new `LocalStorage` instance.
  const LocalStorage();

  /// Opens the local storage database.
  void open();

  /// Initializes Hive, which is the underlying library used for local storage.
  ///
  /// * `subDir`: The subdirectory where Hive should store its data.
  static Future<void> init([
    String? subDir,
  ]) async {
    await Hive.initFlutter(subDir);
  }
}
