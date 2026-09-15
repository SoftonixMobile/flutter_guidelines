import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/models/index.dart';

@Injectable(scope: 'auth')
class UserRepository {
  Future<UserProfile> getUserProfile() async {
    return .fromJson({'userName': 'test'});
  }
}
