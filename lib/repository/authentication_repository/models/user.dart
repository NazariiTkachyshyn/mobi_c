import 'package:equatable/equatable.dart';

import 'storage.dart';

class User extends Equatable {
  final String username;
  final String pass;
  final Storage storage;
  final List<UserRoute> routes;
  final User1C user1C;
  final bool idBlock;
  final Kasa kasa;
  final List<Storage> visibleStorageBalance;

  const User(
      {required this.username,
      required this.pass,
      required this.storage,
      required this.routes,
      required this.user1C,
      required this.idBlock,
      required this.kasa,
      required this.visibleStorageBalance});

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['username'] ?? '',
        pass: json['password'] ?? '',
        storage: Storage.fromJson(
          json['storage'],
        ),
        routes:
            (json['routes'] as List).map((e) => UserRoute.fromJson(e)).toList(),
        user1C: User1C.fromJson(json['user1C']),
        idBlock: json['isBlock'] ?? false,
        kasa: Kasa.fromJson(
          json['kasa'],
        ),
        visibleStorageBalance: (json['visibleStorageBalance'] as List)
            .map((e) => Storage.fromJson(e))
            .toList(),
      );

  static const empty = User(
      username: '',
      pass: '',
      storage: Storage.empty,
      routes: [],
      user1C: User1C.empty,
      idBlock: false,
      kasa: Kasa.empty,
      visibleStorageBalance: []);

  @override
  List<Object?> get props => [username, pass];
}

class UserRoute {
  final String description;
  final String ref;

  UserRoute({required this.description, required this.ref});

  factory UserRoute.fromJson(Map<String, dynamic> json) => UserRoute(
      description: json['Description'] ?? '', ref: json['Ref_Key'] ?? '');
}

class User1C extends Equatable {
  final String description;
  final String ref;

  const User1C({required this.description, required this.ref});

  factory User1C.fromJson(Map<String, dynamic> json) => User1C(
      description: json['Description'] ?? '', ref: json['Ref_Key'] ?? '');

  static const empty = User1C(description: '', ref: '');

  @override
  List<Object?> get props => [description, ref];
}

class Kasa extends Equatable {
  final String description;
  final String ref;
  final String ownerKey;

  const Kasa(
      {required this.description, required this.ref, required this.ownerKey});

  factory Kasa.fromJson(Map<String, dynamic> json) => Kasa(
      description: json['Description'] ?? '',
      ref: json['Ref_Key'] ?? '',
      ownerKey: json['Owner_Key'] ?? '');

  Map<String, dynamic> toJson() =>
      {"Description": description, "Ref_Key": ref, "Owner_Key": ownerKey};

  static const empty = Kasa(description: '', ref: '', ownerKey: '');

  @override
  List<Object?> get props => [description, ref, ownerKey];
}
