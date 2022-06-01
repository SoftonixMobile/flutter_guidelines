import 'dart:io';

import 'package:example/screens/account/models/models.dart';

class AccountRepository {
  static bool isSuccess = true;

  Future<Account> getAccountInfo() async {
    await Future.delayed(const Duration(seconds: 1));

    if ((isSuccess = !isSuccess) == false) {
      return const Account(
        firstName: 'First name',
        lastName: 'Last name',
        age: 18,
      );
    }

    throw const HttpException('Get account data failed');
  }
}
