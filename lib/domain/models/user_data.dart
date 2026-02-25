import 'index.dart';

class UserData {
  UserProfile userProfile;

  UserData({
    required this.userProfile,
  });

  int get id => userProfile.id;
}
