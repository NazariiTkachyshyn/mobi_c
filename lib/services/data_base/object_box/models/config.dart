
import 'package:objectbox/objectbox.dart';

@Entity()
class ConfigOb {
  @Id()
  int id;
  final storages = ToMany<StorageOb>();
  final  dbConn = ToOne<DbConnOb>();
  final  imagesDb = ToOne<ImagesDbOb>();
  final  keys = ToOne<KeysOb>();

  ConfigOb({
    this.id = 0,
 

  });

  
}

@Entity()
class DbConnOb {
  @Id()
  int id;
  final String path;
  final String pass;
  final String host;
  final String user;

  DbConnOb({
    this.id = 0,
    required this.path,
    required this.pass,
    required this.host,
    required this.user,
  });
}

@Entity()
class ImagesDbOb {
  @Id()
  int id;
  final int port;
  final String host;

  ImagesDbOb({
    this.id = 0,
    required this.port,
    required this.host,
  });
}

@Entity()
class KeysOb {
  @Id()
  int id;
  final String unitKey;
  final String priceType;
  final String currencyKey;
  final String organizationKey;

  KeysOb({
    this.id = 0,
    required this.unitKey,
    required this.priceType,
    required this.currencyKey,
    required this.organizationKey,
  });
}

@Entity()
class StorageOb {
  @Id()
  int id;
  final String refKey;
  final String description;

  StorageOb({
    this.id = 0,
    required this.refKey,
    required this.description,
  });
}
