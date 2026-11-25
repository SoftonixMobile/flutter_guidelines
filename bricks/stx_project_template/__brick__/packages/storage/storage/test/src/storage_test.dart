import 'package:storage/storage.dart';
import 'package:test/test.dart';

void main() {
  group(StorageException, () {
    test('exposes the underlying error', () {
      final error = Exception('oops');
      expect(StorageException(error).error, equals(error));
    });
  });
}
