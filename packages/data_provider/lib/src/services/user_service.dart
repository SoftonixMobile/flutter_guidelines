import 'package:injectable/injectable.dart';

import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';

@injectable
class UserService {
  final NetworkBaseClient _networkBaseClient;

  UserService(this._networkBaseClient) {
    _networkBaseClient.registerType(UserProfile.fromJson);
  }

  Future<UserProfile> getUserProfile() async {
    return UserProfile.fromJson({'userName': 'test'});
  }
}
