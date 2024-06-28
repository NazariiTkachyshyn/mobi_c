import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/data_bases/object_box/models/config.dart';

class Config extends Equatable {
  final List<ConfigStorage> storages;
  final DbConn dbConn;
  final ImagesDb imagesDb;
  final Keys keys;

  const Config({
    required this.storages,
    required this.dbConn,
    required this.imagesDb,
    required this.keys,
  });

  Config copyWith({
    List<ConfigStorage>? storages,
    DbConn? dbConn,
    ImagesDb? imagesDb,
    Keys? keys,
  }) =>
      Config(
        storages: storages ?? this.storages,
        dbConn: dbConn ?? this.dbConn,
        imagesDb: imagesDb ?? this.imagesDb,
        keys: keys ?? this.keys,
      );

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      storages: List<ConfigStorage>.from(
          json['storages'].map((storage) => ConfigStorage.fromJson(storage))),
      dbConn: DbConn.fromJson(json['dbConn']),
      imagesDb: ImagesDb.fromJson(json['imagesDb']),
      keys: Keys.fromJson(json['keys']),
    );
  }


  static const Config empty = Config(
    storages: [],
    dbConn: DbConn.empty,
    imagesDb: ImagesDb.empty,
    keys: Keys.empty,
  );


  @override
  List<Object?> get props => [storages, dbConn, imagesDb, keys];
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

class ConfigStorage extends Equatable {
  final String refKey;
  final String description;

  const ConfigStorage({
    required this.refKey,
    required this.description,
  });

  ConfigStorage copyWith({
    String? refKey,
    String? description,
  }) =>
      ConfigStorage(
        refKey: refKey ?? this.refKey,
        description: description ?? this.description,
      );

  factory ConfigStorage.fromJson(Map<String, dynamic> json) {
    return ConfigStorage(
      refKey: json['Ref_Key'],
      description: json['Description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Ref_Key': refKey,
      'Description': description,
    };
  }

  static const ConfigStorage empty = ConfigStorage(
    refKey: '',
    description: '',
  );

  factory ConfigStorage.fromStorageOb(StorageOb storageOb) {
    return ConfigStorage(
      refKey: storageOb.refKey,
      description: storageOb.description,
    );
  }

  @override
  List<Object?> get props => [refKey, description];
}
