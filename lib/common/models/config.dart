import 'package:equatable/equatable.dart';
import 'package:mobi_c/repository/authentication_repository/models/models.dart';
import 'package:mobi_c/services/data_base/object_box/models/config.dart';

class ConfigModel extends Equatable {
  final List<Storage> storages;
  final DbConn dbConn;
  final ImagesDb imagesDb;
  final Keys keys;
  final String userStorage;
  final String responsibleUser;
  final Kasa kasa;
  final List<Storage> visibleStorageBalance;

  const ConfigModel(
      {required this.storages,
      required this.dbConn,
      required this.imagesDb,
      required this.keys,
      required this.userStorage,
      required this.responsibleUser,
      required this.kasa,
      required this.visibleStorageBalance
      });

  ConfigModel copyWith(
          {List<Storage>? storages,
          DbConn? dbConn,
          ImagesDb? imagesDb,
          Keys? keys,
          String? userStorage,
          String? responsibleUser,
          Kasa? kasa,
          List<Storage>? visibleStorageBalance
          }) =>
      ConfigModel(
          storages: storages ?? this.storages,
          dbConn: dbConn ?? this.dbConn,
          imagesDb: imagesDb ?? this.imagesDb,
          keys: keys ?? this.keys,
          userStorage: userStorage ?? this.userStorage,
          responsibleUser: responsibleUser ?? this.responsibleUser,
          kasa: kasa ?? this.kasa,
          visibleStorageBalance: visibleStorageBalance ?? this.visibleStorageBalance
          );

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
        storages: List<Storage>.from(
            json['storages'].map((storage) => Storage.fromJson(storage))),
        dbConn: DbConn.fromJson(json['dbConn']),
        imagesDb: ImagesDb.fromJson(json['imagesDb']),
        keys: Keys.fromJson(json['keys']),
        userStorage: json['userStorage'] ?? '',
        responsibleUser: json['odata_responsible_ref'] ?? '',
        kasa: Kasa.fromJson(json['kasa']),
        visibleStorageBalance: List<Storage>.from(
            json['visibleStorageBalance'].map((storage) => Storage.fromJson(storage))),
        );
  }

  static const ConfigModel empty = ConfigModel(
      storages: [],
      dbConn: DbConn.empty,
      imagesDb: ImagesDb.empty,
      keys: Keys.empty,
      userStorage: '',
      responsibleUser: '',
      kasa: Kasa.empty,
      visibleStorageBalance: []
      );

  @override
  List<Object?> get props =>
      [storages, dbConn, imagesDb, keys, responsibleUser, kasa, visibleStorageBalance];
}

class DbConn extends Equatable {
  final String path;
  final String pass;
  final String host;
  final String user;

  const DbConn({
    required this.path,
    required this.pass,
    required this.host,
    required this.user,
  });

  DbConn copyWith({
    String? path,
    String? pass,
    String? host,
    String? user,
  }) =>
      DbConn(
        path: path ?? this.path,
        pass: pass ?? this.pass,
        host: host ?? this.host,
        user: user ?? this.user,
      );

  factory DbConn.fromJson(Map<String, dynamic> json) {
    return DbConn(
      path: json['path'],
      pass: json['pass'],
      host: json['host'],
      user: json['user'],
    );
  }

  static const DbConn empty = DbConn(
    path: '',
    pass: '',
    host: '',
    user: '',
  );

  @override
  List<Object?> get props => [path, pass, host, user];
}

class ImagesDb extends Equatable {
  final int port;
  final String host;

  const ImagesDb({
    required this.port,
    required this.host,
  });

  ImagesDb copyWith({
    int? port,
    String? host,
  }) =>
      ImagesDb(
        port: port ?? this.port,
        host: host ?? this.host,
      );

  factory ImagesDb.fromJson(Map<String, dynamic> json) {
    return ImagesDb(
      port: json['port'],
      host: json['host'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'port': port,
      'host': host,
    };
  }

  static const ImagesDb empty = ImagesDb(
    port: 0,
    host: '',
  );

  factory ImagesDb.fromImagesDbOb(ImagesDbOb imagesDbOb) {
    return ImagesDb(
      port: imagesDbOb.port,
      host: imagesDbOb.host,
    );
  }

  @override
  List<Object?> get props => [port, host];
}

class Keys extends Equatable {
  final String unitKey;
  final String priceType;
  final String currencyKey;
  final String organizationKey;

  const Keys({
    required this.unitKey,
    required this.priceType,
    required this.currencyKey,
    required this.organizationKey,
  });

  Keys copyWith({
    String? unitKey,
    String? priceType,
    String? currencyKey,
    String? organizationKey,
  }) =>
      Keys(
        unitKey: unitKey ?? this.unitKey,
        priceType: priceType ?? this.priceType,
        currencyKey: currencyKey ?? this.currencyKey,
        organizationKey: organizationKey ?? this.organizationKey,
      );

  factory Keys.fromJson(Map<String, dynamic> json) {
    return Keys(
      unitKey: json['unitKey'],
      priceType: json['priceType'],
      currencyKey: json['currencyKey'],
      organizationKey: json['organizationKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unitKey': unitKey,
      'priceType': priceType,
      'currencyKey': currencyKey,
      'organizationKey': organizationKey,
    };
  }

  static const Keys empty = Keys(
    unitKey: '',
    priceType: '',
    currencyKey: '',
    organizationKey: '',
  );

  factory Keys.fromKeysOb(KeysOb keysOb) {
    return Keys(
      unitKey: keysOb.unitKey,
      priceType: keysOb.priceType,
      currencyKey: keysOb.currencyKey,
      organizationKey: keysOb.organizationKey,
    );
  }

  @override
  List<Object?> get props => [unitKey, priceType, currencyKey, organizationKey];
}

