import 'package:injectable/injectable.dart';

import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';

@injectable
class UserService {
  final ApiClient _client;

  UserService(this._client) {
    _client.registerType(UserProfile.fromJson);
  }

  Future<UserProfile> getUserProfile() async {
    return UserProfile.fromJson({'userName': 'test'});
  }
}
