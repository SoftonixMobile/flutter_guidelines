import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secure_storage/secure_storage.dart';
import 'package:storage/storage.dart';

class _MockFlutterSecureStorage extends Mock implements FlutterSecureStorage;

void main() {
  const key = 'key';
  const value = 'value';

  group(SecureStorage, () {
    late FlutterSecureStorage flutterSecureStorage;
    late SecureStorage storage;

    setUp(() {
      flutterSecureStorage = _MockFlutterSecureStorage();
      storage = SecureStorage(secureStorage: flutterSecureStorage);
    });

    test('can be instantiated without a secure storage', () {
      expect(SecureStorage.new, returnsNormally);
    });

    group('read', () {
      test('returns the stored value', () async {
        when(() => flutterSecureStorage.read(key: key))
            .thenAnswer((_) async => value);

        expect(await storage.read(key: key), equals(value));
      });

      test('throws StorageException when the read fails', () {
        when(() => flutterSecureStorage.read(key: key))
            .thenThrow(Exception('oops'));

        expect(storage.read(key: key), throwsA(isA<StorageException>()));
      });
    });

    group('write', () {
      test('stores the value', () async {
        when(() => flutterSecureStorage.write(key: key, value: value))
            .thenAnswer((_) async {});

        await storage.write(key: key, value: value);

        verify(() => flutterSecureStorage.write(key: key, value: value))
            .called(1);
      });

      test('throws StorageException when the write fails', () {
        when(() => flutterSecureStorage.write(key: key, value: value))
            .thenThrow(Exception('oops'));

        expect(
          storage.write(key: key, value: value),
          throwsA(isA<StorageException>()),
        );
      });
    });

    group('delete', () {
      test('removes the value', () async {
        when(() => flutterSecureStorage.delete(key: key))
            .thenAnswer((_) async {});

        await storage.delete(key: key);

        verify(() => flutterSecureStorage.delete(key: key)).called(1);
      });

      test('throws StorageException when the delete fails', () {
        when(() => flutterSecureStorage.delete(key: key))
            .thenThrow(Exception('oops'));

        expect(storage.delete(key: key), throwsA(isA<StorageException>()));
      });
    });
  });
}
