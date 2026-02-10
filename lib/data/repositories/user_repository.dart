import 'package:data_provider/data_provider.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(scope: 'auth')
class UserRepository {
  final UserService _userService;

  UserProfile? _userProfile;

  UserRepository(this._userService);

  UserProfile get userProfile => _userProfile ?? const UserProfile();

  Future<UserProfile> getUserProfile() async {
    return _userProfile ??= await _userService.getUserProfile();
  }
}
