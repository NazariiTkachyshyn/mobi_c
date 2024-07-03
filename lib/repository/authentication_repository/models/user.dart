import 'package:equatable/equatable.dart';

import 'storage.dart';

class User extends Equatable {
  final String username;
  final String pass;
  final Storage storage;
  final List<UserRoute> routes;
  final String responsibleUser;

  const User(
      {required this.username,
      required this.pass,
      required this.storage,
      required this.routes,
      required this.responsibleUser
      });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'] ?? '',
        pass: json['password'] ?? '',
        storage: Storage.fromJson(
          json['storage'],
        ),
        routes:
            (json['routes'] as List).map((e) => UserRoute.fromJson(e)).toList(),
            responsibleUser: json['odata_responsible_ref'] ?? ''
      );

  static const empty =
      User(username: '', pass: '', storage: Storage.empty, routes: [], responsibleUser: '');

  @override
  List<Object?> get props => [username, pass];
}

class UserRoute {
  final String description;
  final String ref;

  UserRoute({required this.description, required this.ref});

  factory UserRoute.fromJson(Map<String, dynamic> json) => UserRoute(
      description: json['description'] ?? '', ref: json['refKey'] ?? '');
}
