import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_repository/stx_repository.dart';

import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';

@LazySingleton(scope: 'auth')
class UserRepository extends RepositoryBase<UserProfile> {
  final UserData _userData;
  final UserService _userService;

  UserRepository(this._userData, this._userService)
    : super(initialValue: const UserProfile());

  FutureOr<UserProfile> getUserProfile({bool refreshData = false}) {
    return load(_userService.getUserProfile, refresh: refreshData);
  }

  @override
  Future<UserProfile> onRefresh(
    Future<UserProfile> Function() loadCallback,
  ) async {
    return _userData.userProfile = await super.onRefresh(loadCallback);
  }
}
