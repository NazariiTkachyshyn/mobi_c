import 'package:equatable/equatable.dart';

import 'storage.dart';

class User extends Equatable {
  final String username;
  final String pass;
  final Storage storage;

  const User({required this.username, required this.pass, required this.storage});

  factory User.fromJson(Map<String, dynamic> json) => User(
      username: json['username'] ?? '',
      pass: json['password'] ?? '',
      storage: Storage.fromJson(json['storage']));

  static const empty = User(username: '', pass: '', storage: Storage.empty);

  @override
  List<Object?> get props => [username, pass];
}
