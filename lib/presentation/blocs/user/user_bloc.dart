import 'package:data_provider/models.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/data/repositories/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';

typedef UserState = NetworkState<UserProfile>;

@singleton
class UserBloc extends NetworkBloc<UserProfile, UserState> {
  final UserData _userData;
  final UserRepository _userRepository;

  UserBloc(this._userData, this._userRepository)
    : super(UserState(data: _userData.userProfile));

  @override
  Future<UserProfile> onLoadAsync() async {
    final userProfile = await _userRepository.getUserProfile();

    _userData.userProfile = userProfile;
    return userProfile;
  }
}
