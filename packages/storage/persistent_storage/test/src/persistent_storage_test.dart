import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:storage/storage.dart';

class _MockSharedPreferencesAsync extends Mock
    implements SharedPreferencesAsync;

void main() {
  const key = 'key';
  const value = 'value';

  group(PersistentStorage, () {
    late SharedPreferencesAsync sharedPreferences;
    late PersistentStorage storage;

    setUp(() {
      sharedPreferences = _MockSharedPreferencesAsync();
      storage = PersistentStorage(sharedPreferences: sharedPreferences);
    });

    test('can be instantiated without shared preferences', () {
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();

      expect(PersistentStorage.new, returnsNormally);
    });

    group('read', () {
      test('returns the stored value', () async {
        when(() => sharedPreferences.getString(key))
            .thenAnswer((_) async => value);

        expect(await storage.read(key: key), equals(value));
      });

      test('throws StorageException when the read fails', () {
        when(() => sharedPreferences.getString(key)).thenThrow(Exception());

        expect(storage.read(key: key), throwsA(isA<StorageException>()));
      });
    });

    group('write', () {
      test('stores the value', () async {
        when(() => sharedPreferences.setString(key, value))
            .thenAnswer((_) async {});

        await storage.write(key: key, value: value);

        verify(() => sharedPreferences.setString(key, value)).called(1);
      });

      test('throws StorageException when the write fails', () {
        when(() => sharedPreferences.setString(key, value))
            .thenThrow(Exception());

        expect(
          storage.write(key: key, value: value),
          throwsA(isA<StorageException>()),
        );
      });
    });

    group('delete', () {
      test('removes the value', () async {
        when(() => sharedPreferences.remove(key)).thenAnswer((_) async {});

        await storage.delete(key: key);

        verify(() => sharedPreferences.remove(key)).called(1);
      });

      test('throws StorageException when the delete fails', () {
        when(() => sharedPreferences.remove(key)).thenThrow(Exception());

        expect(storage.delete(key: key), throwsA(isA<StorageException>()));
      });
    });
  });
}
