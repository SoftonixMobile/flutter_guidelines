import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NetworkStatus {
  loading,
  success,
  failure;

  bool get isLoading => this == NetworkStatus.loading;
  bool get isSuccess => this == NetworkStatus.success;
  bool get isFailure => this == NetworkStatus.failure;
}

class NetworkStateBase<T> extends Equatable {
  const NetworkStateBase({
    this.status = NetworkStatus.loading,
    required this.data,
    this.errorMessage,
  });

  final NetworkStatus status;
  final T data;
  final String? errorMessage;

  String get errorMsg => errorMessage ?? 'Something went wrong';

  ///subClassMustOverride
  NetworkStateBase<T> copyWith({
    NetworkStatus? status,
    T? data,
    String? errorMessage,
  }) {
    return NetworkStateBase(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}

abstract class NetworkEventBase {}

class NetworkEventLoadAsync implements NetworkEventBase {}

class NetworkEventUpdate<T> implements NetworkEventBase {
  const NetworkEventUpdate(this.updatedData);

  final T updatedData;
}

class NetworkEventUpdateAsync<T> implements NetworkEventBase {
  const NetworkEventUpdateAsync(this.updatedData);

  final T updatedData;
}

abstract class NetworkBlocBase<T, S extends NetworkStateBase<T>>
    extends Bloc<NetworkEventBase, S> {
  NetworkBlocBase(
    super.initialState, {
    this.errorHandler,
  }) {
    on<NetworkEventLoadAsync>(onEventLoadAsync);
    on<NetworkEventUpdate>(onEventUpdate);
    on<NetworkEventUpdateAsync>(onEventUpdateAsync);
  }

  final String? Function(Object)? errorHandler;

  void loadAsync() => add(NetworkEventLoadAsync());
  void updateData(T updatedData) => add(NetworkEventUpdate(updatedData));
  void updateDataAsync(T updatedData) =>
      add(NetworkEventUpdateAsync(updatedData));

  FutureOr<void> onEventLoadAsync(
      NetworkEventLoadAsync event, Emitter<NetworkStateBase<T>> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));

    try {
      var data = await onLoadDataAsync();

      emit(state.copyWith(status: NetworkStatus.success, data: data));
    } catch (e) {
      emit(
        state.copyWith(
          status: NetworkStatus.failure,
          errorMessage: errorHandler?.call(e),
        ),
      );
    }
  }

  FutureOr<void> onEventUpdate(
      NetworkEventUpdate event, Emitter<NetworkStateBase<T>> emit) {
    emit(state.copyWith(data: event.updatedData));
  }

  FutureOr<void> onEventUpdateAsync(
      NetworkEventUpdateAsync event, Emitter<NetworkStateBase<T>> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));

    try {
      var data = await onUpdateDataAsync(event.updatedData);

      emit(NetworkStateBase(data: data));
    } catch (e) {
      emit(
        state.copyWith(
          status: NetworkStatus.failure,
          errorMessage: errorHandler?.call(e),
        ),
      );
    }
  }

  Future<T> onLoadDataAsync();

  Future<T> onUpdateDataAsync(T updatedData) {
    return Future.value(updatedData);
  }
}
