import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_bloc_base/stx_bloc_base.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/domain/repositories/index.dart';

typedef UserState = NetworkState<UserProfile>;

@singleton
class UserBloc(
  final UserRepository _userRepository,
) extends NetworkBloc<UserProfile, UserState> {
  this : super(const UserState(data: UserProfile()));

  @override
  FutureOr<UserProfile> onLazyLoad() {
    return _userRepository.getUserProfile();
  }

  @override
  Future<UserProfile> onLoadAsync() async {
    return await _userRepository.getUserProfile(refresh: true);
  }
}
