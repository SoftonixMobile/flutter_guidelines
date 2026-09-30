/// {@template storage_exception}
/// Thrown when a [Storage] operation fails.
/// {@endtemplate}
class StorageException implements Exception {
  /// {@macro storage_exception}
  const new(this.error);

  /// The underlying error that caused the failure.
  final Object error;
}

/// A key-value storage interface.
abstract interface class Storage {
  /// Returns the value stored under [key], or `null` when there is none.
  ///
  /// Throws a [StorageException] when the read fails.
  Future<String?> read({required String key});

  /// Stores [value] under [key].
  ///
  /// Throws a [StorageException] when the write fails.
  Future<void> write({required String key, required String value});

  /// Removes the value stored under [key].
  ///
  /// Throws a [StorageException] when the delete fails.
  Future<void> delete({required String key});
}
