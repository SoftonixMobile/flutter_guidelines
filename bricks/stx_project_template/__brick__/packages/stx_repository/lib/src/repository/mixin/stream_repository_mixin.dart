import 'dart:async';

import 'disposable_repository_mixin.dart';

mixin StreamRepositoryMixin<T> on DisposableRepositoryMixin<T> {
  late final _streamController = StreamController<T>.broadcast();

  Stream<T> get stream => _streamController.stream;
  bool get isClosed => _streamController.isClosed;

  @override
  void emit(T value) {
    if (!isClosed) {
      _streamController.add(value);
    }

    return super.emit(value);
  }

  @override
  Future<void> close() async {
    await _streamController.close();

    return super.close();
  }
}
