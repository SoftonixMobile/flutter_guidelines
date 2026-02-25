import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_bloc_base/stx_bloc_base.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/domain/repositories/index.dart';

typedef UserState = NetworkState<UserProfile>;

@singleton
class UserBloc extends NetworkBloc<UserProfile, UserState> {
  final UserData _userData;
  final UserRepository _userRepository;

  UserBloc(
    this._userData,
    this._userRepository,
  ) : super(UserState(data: _userData.userProfile));

  @override
  FutureOr<UserProfile> onLazyLoad() async {
    final userProfile = await _userRepository.getUserProfile();

    return _userData.userProfile = userProfile;
  }

  @override
  Future<UserProfile> onLoadAsync() async {
    final userProfile = await _userRepository.getUserProfile(
      refreshData: true,
    );

    return _userData.userProfile = userProfile;
  }
}
