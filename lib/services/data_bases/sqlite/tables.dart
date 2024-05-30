import 'package:mobi_c/common/constants/table_named.dart';
import 'package:sqflite/sqflite.dart';

class SqliteTables {
  Future<void> createTable(Database database) async {
    await database.execute('''
CREATE TABLE IF NOT EXISTS $tableNoms (
  $fieldId INTEGER PRIMARY KEY AUTOINCREMENT,
  "Ref_Key" TEXT,
  $fieldIsFolder INTEGER,
  $fieldDescription TEXT,
  $fieldArticle TEXT,
  $fieldParentKey TEXT,
  $fieldBaseUnitKey TEXT,
  $fieldImageKey TEXT
);
''');
    await database.execute('''
CREATE TABLE IF NOT EXISTS $tablePrices (
  $fieldRefKey TEXT,
  $fieldNomKey TEXT,
  $fieldPrice REAL,
  $fieldPriceTypeKey TEXT,
  $fieldPackagingKey TEXT,
  $fieldCurrencyKey TEXT
);
''');

    await database.execute('''
CREATE TABLE IF NOT EXISTS $tableCounterparty (
  $fieldRefKey TEXT,
  $fieldMainCounterpartyKey TEXT,
  $fieldPartnerKey TEXT,
  $fieldDescription TEXT,
  $fieldFullName TEXT
);
''');

    await database.execute('''
CREATE TABLE IF NOT EXISTS $tableContract (
  $fieldRefKey TEXT,
  $fieldOwnerKey TEXT,
  $fieldOrganizationKey TEXT,
  $fieldDescription TEXT
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

    await database.execute('''
CREATE TABLE IF NOT EXISTS $tableDiscount (
  $fieldDiscountRecipient TEXT,
  $fieldPercentDiscounts REAL
);
''');
  }
}
