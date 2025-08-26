import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/services/http/index.dart';

@Injectable(scope: 'auth')
class UserRepository {
  final HttpClient httpClient;

  UserRepository(this.httpClient);

  Future<UserProfile> getUserProfile() async {
    return UserProfile.fromJson({'userName': 'test'});
  }
}
