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
  Future<T> refresh(Future<T> Function() loadCallback) {
    _lastRefreshTime = DateTime.now();

    return super.refresh(loadCallback);
  }
}
