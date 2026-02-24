import 'dart:async';

import 'disposable_repository_mixin.dart';

mixin SyncLoadRepositoryMixin<T> on DisposableRepositoryMixin<T> {
  Completer<T>? _loadCompleter;

  @override
  Future<T> onRefresh(Future<T> Function() loadCallback) {
    if (_loadCompleter != null) {
      return _loadCompleter!.future;
    }

    _loadCompleter = Completer<T>();

    try {
      final result = super.onRefresh(loadCallback);

      _loadCompleter!.complete(result);
    } catch (e) {
      _loadCompleter!.completeError(e);
      rethrow;
    } finally {
      _loadCompleter = null;
    }

    return _loadCompleter!.future;
  }

  @override
  FutureOr<void> close() {
    _loadCompleter?.completeError(
      Exception('Repository was closed while loading'),
      StackTrace.current,
    );

    _loadCompleter = null;

    return super.close();
  }
}
