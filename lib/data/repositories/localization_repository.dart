import 'package:injectable/injectable.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:storage/storage.dart';

@LazySingleton(scope: 'app')
class LocalizationRepository(final PersistentStorage _storage) {
  static const languageKey = 'language_code';

  Future<String?> getLanguageCode() async {
    try {
      return await _storage.read(key: languageKey);
    } on StorageException {
      return null;
    }
  }

  Future<void> saveLanguageCode(String code) {
    return _storage.write(key: languageKey, value: code);
  }
}
