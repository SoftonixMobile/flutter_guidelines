import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/models/index.dart';
import 'package:{{project_name}}/repositories/index.dart';

part 'chats_event.dart';
part 'chats_state.dart';
part 'chats_bloc.freezed.dart';

@lazySingleton
class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final ChatsRepository _chatsRepository;

  ChatsBloc(this._chatsRepository) : super(const ChatsState()) {
    on<_Load>(_load);
  }

  FutureOr<void> _load(_Load event, Emitter<ChatsState> emit) async {
    emit(state.copyWith(status: NetworkStatus.loading));

    try {
      final chats = await _chatsRepository.getChats();

      emit(ChatsState.success(chats));
    } catch (e, stackTrace) {
      addError(e, stackTrace);

      emit(state.copyWith(status: NetworkStatus.failure));
    }
  }
}
