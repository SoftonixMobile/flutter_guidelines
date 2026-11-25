import 'dart:async';

import 'package:meta/meta.dart';

import '../base/index.dart';

mixin DisposableRepositoryMixin<T> on RepositoryBase<T> {
  @mustCallSuper
  FutureOr<void> close() {}
}
