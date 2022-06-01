import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stx_bloc_base/src/helpers.dart';
import 'package:stx_bloc_base/src/network_base_bloc.dart';
import 'package:stx_bloc_base/src/network_error_types.dart';

enum AddPosition {
  start,
  end;

  bool get isStart => this == AddPosition.start;
  bool get isEnd => this == AddPosition.end;
}

class NetworkListStateBase<T> extends NetworkStateBase<List<T>> {
  const NetworkListStateBase({
    super.status,
    super.data = const [],
    super.errorMessage,
  });

  @override
  NetworkListStateBase<T> copyWith({
    NetworkStatus? status,
    List<T>? data,
    String? errorMessage,
  }) {
    return NetworkListStateBase(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class NetworkEventAdd<T> implements NetworkEventBase {
  NetworkEventAdd(
    this.newItem, {
    this.position = AddPosition.end,
  });

  final T newItem;
  final AddPosition position;
}

class NetworkEventAddAsync<T> implements NetworkEventBase {
  NetworkEventAddAsync(
    this.newItem, {
    this.position = AddPosition.end,
  });

  final T newItem;
  final AddPosition position;
}

class NetworkEventEdit<T> implements NetworkEventBase {
  NetworkEventEdit(this.updatedItem);

  final T updatedItem;
}

class NetworkEventEditAsync<T> implements NetworkEventBase {
  NetworkEventEditAsync(this.updatedItem);

  final T updatedItem;
}

class NetworkEventRemove<T> implements NetworkEventBase {
  NetworkEventRemove(this.item);

  final T item;
}

class NetworkEventRemoveAsync<T> implements NetworkEventBase {
  NetworkEventRemoveAsync(this.item);

  final T item;
}

abstract class NetworkListBlocBase<T, S extends NetworkListStateBase<T>>
    extends NetworkBlocBase<List<T>, S> {
  NetworkListBlocBase(
    super.initialState, {
    super.errorHandler,
  }) {
    on<NetworkEventAdd<T>>(onEventAddItem);
    on<NetworkEventAddAsync<T>>(onEventAddItemAsync);
    on<NetworkEventEdit<T>>(onEventEditItem);
    on<NetworkEventEditAsync<T>>(onEventEditItemAsync);
    on<NetworkEventRemove>(onEventRemoveItem);
    on<NetworkEventRemoveAsync>(onEventRemoveItemAsync);
  }

  void addItem(T newItem) => add(NetworkEventAdd(newItem));

  void addItemAsync(T newItem) => add(NetworkEventAddAsync(newItem));

  void editItem(T updatedItem) => add(NetworkEventEdit(updatedItem));

  void editItemAsync(T updatedItem) => add(NetworkEventEditAsync(updatedItem));

  void removeItem(T item) => add(NetworkEventRemove(item));

  void removeItemAsync(T item) => add(NetworkEventRemoveAsync(item));

  FutureOr<void> onEventAddItem(
      NetworkEventAdd<T> event, Emitter<NetworkListStateBase<T>> emit) {
    final items = [
      if (event.position.isStart) event.newItem,
      ...state.data,
      if (event.position.isEnd) event.newItem,
    ];

    emit(state.copyWith(status: NetworkStatus.success, data: items));
  }

  FutureOr<void> onEventAddItemAsync(NetworkEventAddAsync<T> event,
      Emitter<NetworkListStateBase<T>> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));

    try {
      var newItem = await onAddItemAsync(event.newItem);

      final items = [
        if (event.position.isStart) newItem,
        ...state.data,
        if (event.position.isEnd) newItem,
      ];

      emit(state.copyWith(status: NetworkStatus.success, data: items));
    } catch (e) {
      emit(
        state.copyWith(
          status: NetworkStatus.failure,
          errorMessage: errorHandler?.call(e),
        ),
      );
    }
  }

  FutureOr<void> onEventEditItem(
      NetworkEventEdit<T> event, Emitter<NetworkListStateBase<T>> emit) {
    final items = state.data.replaceWhere(
      (item) => equals(item, event.updatedItem),
      (_) => event.updatedItem,
    );

    emit(state.copyWith(status: NetworkStatus.success, data: items));
  }

  FutureOr<void> onEventEditItemAsync(NetworkEventEditAsync<T> event,
      Emitter<NetworkListStateBase<T>> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));

    try {
      var updatedItem = await onEditItemAsync(event.updatedItem);

      final items = state.data.replaceWhere(
        (item) => equals(item, updatedItem),
        (_) => updatedItem,
      );

      emit(state.copyWith(status: NetworkStatus.success, data: items));
    } catch (e) {
      emit(
        state.copyWith(
          status: NetworkStatus.failure,
          errorMessage: errorHandler?.call(e),
        ),
      );
    }
  }

  FutureOr<void> onEventRemoveItem(
      NetworkEventRemove event, Emitter<NetworkListStateBase<T>> emit) {
    final items = [...state.data]..removeWhere(
        (item) => equals(item, event.item),
      );

    emit(state.copyWith(status: NetworkStatus.success, data: items));
  }

  FutureOr<void> onEventRemoveItemAsync(NetworkEventRemoveAsync event,
      Emitter<NetworkListStateBase<T>> emit) async {
    final oldItems = [...state.data];

    try {
      final items = [...state.data]..removeWhere(
          (item) => equals(item, event.item),
        );

      emit(state.copyWith(status: NetworkStatus.success, data: items));

      final response = await onDeleteItemAsync(event.item);

      if (!response) {
        throw NetworkDeleteException('Couldn\'t remove item.');
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: NetworkStatus.failure,
          data: oldItems,
          errorMessage: errorHandler?.call(e),
        ),
      );
    }
  }

  Future<T> onAddItemAsync(T newItem) {
    return Future.value(newItem);
  }

  Future<T> onEditItemAsync(T updatedItem) {
    return Future.value(updatedItem);
  }

  Future<bool> onDeleteItemAsync(T item) {
    return Future.value(true);
  }

  bool equals(T item1, T item2);
}
