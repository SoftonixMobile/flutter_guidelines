import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/domain/repositories/index.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@Injectable(scope: 'auth')
class AuthBloc(final AuthRepository _authRepository)
    extends Bloc<AuthEvent, AuthState> {
  this : super(const AuthState()) {
    on<_Subscribe>(_subscribe);
    on<_SignOut>(_signOut);
  }

  Future<void> _subscribe(
    _Subscribe event,
    Emitter<AuthState> emit,
  ) {
    return emit.forEach(
      _authRepository.onStatusChanged,
      onData: (status) => state.copyWith(status: status),
    );
  }

  FutureOr<void> _signOut(_SignOut event, Emitter<AuthState> emit) {
    return _authRepository.signOut();
  }
}
