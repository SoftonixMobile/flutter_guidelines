import 'package:api_client/api_client.dart';
import 'package:app_api/models.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserService(final ApiClient _client) {
  this {
    _client.registerType(UserProfileDto.fromJson);
  }

  Future<UserProfileDto> getUserProfile() async {
    await Future.delayed(Duration(seconds: 1));

    return UserProfileDto.fromJson({
      'id': 1,
      'userName': 'test',
    });
  }
}
