import 'dart:async';

import 'package:meta/meta.dart';

abstract class RepositoryBase<T> {
  T _data;
  bool _isDataLoaded = false;

  RepositoryBase({required T initialValue}) : _data = initialValue;

  T get data => _data;
  bool get isDataLoaded => _isDataLoaded;

  @mustCallSuper
  bool shouldRefreshData() => !_isDataLoaded;

  @protected
  FutureOr<T> load(Future<T> Function() loadCallback, {bool refresh = false}) {
    var loadedValue = data;

    if (refresh || shouldRefreshData()) {
      return this.refresh(loadCallback);
    }

    return loadedValue;
  }

  @protected
  Future<T> refresh(Future<T> Function() loadCallback) async {
    final loadedValue = await loadCallback();
    _isDataLoaded = true;

    emit(loadedValue);

    return loadedValue;
  }

  @mustCallSuper
  void emit(T value) {
    _data = value;
  }
}
