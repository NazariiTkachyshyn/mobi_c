part of 'config_cubit.dart';

final class ConfigState extends Equatable {
  const ConfigState(
      {DbConn? configOb,
      ImagesDb? imagesdb,
      Keys? keys,
      List<ConfigStorage>? storages})
      : dbConn = configOb ?? DbConn.empty,
        imagesDb = imagesdb ?? ImagesDb.empty,
        keys = keys ?? Keys.empty,
        storages = storages ?? const [];

  final DbConn dbConn;
  final ImagesDb imagesDb;
  final Keys keys;
  final List<ConfigStorage> storages;

  ConfigState copyWith(
      {DbConn? dbConn,
      ImagesDb? imagesDb,
      Keys? keys,
      List<ConfigStorage>? storages}) {
    return ConfigState(
        configOb: dbConn ?? this.dbConn,
        imagesdb: imagesDb ?? this.imagesDb,
        keys: keys ?? this.keys,
        storages: storages ?? this.storages);
  }

  @override
  List<Object?> get props => [dbConn, imagesDb, keys, storages];
}
