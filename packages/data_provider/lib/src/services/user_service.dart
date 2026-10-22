import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserService(final ApiClient _client) {
  this {
    _client.registerType(UserProfile.fromJson);
  }

  Future<UserProfile> getUserProfile() async {
    await Future.delayed(Duration(seconds: 1));

    return UserProfile.fromJson({
      'id': 1,
      'userName': 'test',
    });
  }
}
