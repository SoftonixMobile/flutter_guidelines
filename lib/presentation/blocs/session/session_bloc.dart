import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/domain/repositories/index.dart';

part 'session_bloc.freezed.dart';
part 'session_event.dart';
part 'session_state.dart';

@Injectable(scope: 'app')
class SessionBloc(final AuthRepository _authRepository)
    extends Bloc<SessionEvent, SessionState> {
  this : super(const SessionState()) {
    on<_Subscribe>(_subscribe);
    on<_SignOut>(_signOut);
  }

  Future<void> _subscribe(
    _Subscribe event,
    Emitter<SessionState> emit,
  ) {
    return emit.forEach(
      _authRepository.onAuthStatusChanged,
      onData: (status) => state.copyWith(authStatus: status),
    );
  }

  FutureOr<void> _signOut(_SignOut event, Emitter<SessionState> emit) {
    return _authRepository.signOut();
  }
}
