import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQFLiteServices {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> fullPath() async {
    const name = 'test23.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath();
    var database = await openDatabase(path,
        version: 1, onCreate: create, singleInstance: true);
    return database;
  }

  Future<void> create(Database database, int version) async =>
      await KeysDB().createTable(database);
}

class KeysDB {
  Future<void> createTable(Database database) async {
    await database.execute('''
CREATE TABLE IF NOT EXISTS noms (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "Ref_Key" TEXT,
  "IsFolder" INTEGER,
  "Description" TEXT,
  "Артикул" TEXT,
  "Parent_Key" TEXT,
  "БазоваяЕдиницаИзмерения_Key" TEXT,
  "ФайлКартинки_Key" TEXT
);
''');
    await database.execute('''
CREATE TABLE IF NOT EXISTS prices (
  "Номенклатура_Key" TEXT ,
  "Цена" REAL,
  "ВидЦены_Key" TEXT ,
  "Упаковка_Key" TEXT ,
  "Валюта_Key" TEXT 
);
''');

    await database.execute('''
CREATE TABLE IF NOT EXISTS counterparty (
  "Ref_Key" TEXT ,
  "ГоловнойКонтрагент_Key" TEXT,
  "Партнер_Key" TEXT ,
  "Description" TEXT ,
  "НаименованиеПолное" TEXT 
);
''');
    await database.execute('''
CREATE TABLE IF NOT EXISTS orderProduct (
  "id"  INTEGER PRIMARY KEY AUTOINCREMENT ,
  "orderId" INTEGER,
  "ref" TEXT,
  "description" TEXT ,
  "article" TEXT ,
  "imageKey" TEXT,
  "unitKey" TEXT,
  "priceType" TEXT ,
  "price" REAL ,
  "qty" INTEGER
);
''');
  }
}
