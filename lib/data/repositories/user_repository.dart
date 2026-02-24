import 'dart:async';

import 'package:data_provider/data_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:stx_repository/stx_repository.dart';

@LazySingleton(scope: 'auth')
class UserRepository extends RepositoryBase<UserProfile> {
  final UserService _userService;

  UserRepository(this._userService) : super(initialValue: const UserProfile());

  FutureOr<UserProfile> getUserProfile({bool refreshData = false}) {
    return load(_userService.getUserProfile, refresh: refreshData);
  }
}
