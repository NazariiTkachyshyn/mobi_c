import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobi_c/auth/models.dart/user.dart';
import 'package:mobi_c/common/models/config.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(''),
    );
  }

  Future<Config> getConfig() async {
    final config = await FirebaseFirestore.instance.collection('config').get();
    final configData = config.docs;
    return Config.fromJson(configData.first.data());
  }
}
