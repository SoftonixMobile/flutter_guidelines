import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserService {
  final NetworkBaseClient _networkBaseClient;

  UserService(this._networkBaseClient) {
    _networkBaseClient.registerType(UserProfile.fromJson);
  }

  Future<UserProfile> get() async {
    return UserProfile.fromJson({'userName': 'test'});
  }
}
