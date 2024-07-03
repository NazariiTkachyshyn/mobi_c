import 'dart:async';

import 'package:mobi_c/auth/models.dart/user.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(''),
    );
  }


}
