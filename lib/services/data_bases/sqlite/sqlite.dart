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
    const name = 'test17.db';
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
  "ref" TEXT,
  "description" TEXT,
  "article" TEXT,
  "unitKey" TEXT,
  "parentKey" TEXT,
  "isFolder" INTEGER
);
''');
    await database.execute('''
CREATE TABLE IF NOT EXISTS prices (
  "nomKey" TEXT ,
  "price" REAL,
  "priceType" TEXT ,
  "packKey" TEXT ,
  "currencyKey" TEXT 
);
''');
  }
}
