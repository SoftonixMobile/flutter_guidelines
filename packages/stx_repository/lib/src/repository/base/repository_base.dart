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
  Future<T> load(
    Future<T> Function() loadCallback, {
    bool refresh = false,
  }) async {
    var loadedValue = data;

    if (refresh || shouldRefreshData()) {
      loadedValue = await loadCallback();
      _isDataLoaded = true;

      emit(loadedValue);
    }

    return loadedValue;
  }

  @mustCallSuper
  void emit(T value) {
    _data = value;
  }
}
