import '../base/repository_base.dart';

mixin TtlRefreshRepositoryMixin<T> on RepositoryBase<T> {
  Duration get cacheTtl;

  DateTime? _lastRefreshTime;

  @override
  bool shouldRefreshData() {
    final now = DateTime.now();

    if (_lastRefreshTime != null &&
        now.difference(_lastRefreshTime!) < cacheTtl) {
      return false;
    }

    return super.shouldRefreshData();
  }

  @override
  Future<T> load(
    Future<T> Function() loadCallback, {
    bool forceDataRefresh = false,
  }) async {
    var loadedValue = data;

    if (forceDataRefresh || shouldRefreshData()) {
      _lastRefreshTime = DateTime.now();
      loadedValue = await loadCallback();

      emit(loadedValue);
    }

    return loadedValue;
  }
}
