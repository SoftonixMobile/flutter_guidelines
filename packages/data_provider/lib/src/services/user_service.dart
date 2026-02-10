import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserService {
  final NetworkBaseClient _networkBaseClient;

  UserService(this._networkBaseClient);

  Future<UserProfile> getUserProfile() async {
    return UserProfile.fromJson({'userName': 'test'});
  }
}
