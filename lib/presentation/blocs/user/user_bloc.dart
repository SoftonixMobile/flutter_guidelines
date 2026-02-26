import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_bloc_base/stx_bloc_base.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/domain/repositories/index.dart';

typedef UserState = NetworkState<UserProfile>;

@singleton
class UserBloc extends NetworkBloc<UserProfile, UserState> {
  final UserRepository _userRepository;

  UserBloc(
    this._userRepository,
  ) : super(const UserState(data: UserProfile()));

  @override
  FutureOr<UserProfile> onLazyLoad() async {
    return _userRepository.getUserProfile();
  }

  @override
  Future<UserProfile> onLoadAsync() async {
    return _userRepository.getUserProfile(refresh: true);
  }
}
