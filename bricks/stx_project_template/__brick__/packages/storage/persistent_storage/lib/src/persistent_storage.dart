import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';

/// {@template persistent_storage}
/// A [Storage] that keeps non-sensitive values in shared preferences.
/// {@endtemplate}
class PersistentStorage implements Storage {
  /// {@macro persistent_storage}
  new({SharedPreferencesAsync? sharedPreferences})
    : _sharedPreferences = sharedPreferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _sharedPreferences;

  @override
  Future<String?> read({required String key}) async {
    try {
      return await _sharedPreferences.getString(key);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  @override
  Future<void> write({required String key, required String value}) async {
    try {
      await _sharedPreferences.setString(key, value);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      await _sharedPreferences.remove(key);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }
}
