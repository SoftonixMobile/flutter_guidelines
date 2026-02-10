import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/domain/models/index.dart';

@Injectable(scope: 'auth')
class UserRepository {
  UserRepository();

  Future<UserProfile> getUserProfile() async {
    return UserProfile.fromJson({'userName': 'test'});
  }
}
