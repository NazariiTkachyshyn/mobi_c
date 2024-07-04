import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mobi_c/repository/authentication_repository/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    final prefs = await SharedPreferences.getInstance();
    final bool isLogin = prefs.getBool('isLogin') ?? false;
    if (isLogin) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<User> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final users = FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password);
      final snapshot = await users.get();
      final data = snapshot.docs;
      List<User> userList =
          data.map((doc) => User.fromJson(doc.data())).toList();

      if (userList.isEmpty) {
        _controller.add(AuthenticationStatus.unauthenticated);
        throw UserNotFoundFailure();
      }
      if (userList.first.idBlock == true) {
        _controller.add(AuthenticationStatus.unauthenticated);
        throw UserBlockedFailure();
      }

      _controller.add(AuthenticationStatus.authenticated);
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLogin', true);
      return userList.first;
    } catch (e) {
      if (e is SocketException) {
        throw LoginRequestFailure();
      } else {
        rethrow;
      }
    }
  }

  void logOut() async {
    _controller.add(AuthenticationStatus.unauthenticated);
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
  }

  void dispose() => _controller.close();
}

class LoginRequestFailure implements Exception {}

class UserNotFoundFailure implements Exception {}

class UserBlockedFailure implements Exception {}
