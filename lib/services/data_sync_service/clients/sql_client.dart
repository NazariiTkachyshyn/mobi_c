import 'package:mobi_c/common/constants/table_named.dart';
import 'package:mobi_c/models/models.dart';

import 'package:sqflite/sqflite.dart';

class DataSyncDbClient {
  final Database _sqlite;

  DataSyncDbClient({required Database sqlite}) : _sqlite = sqlite;

  //^----------NOMENKLATURA----------------
  Future<List<ApiNom>> getAllNoms() async {
    try {
      final noms = await _sqlite.query(tableNoms);

      return noms.map((e) => ApiNom.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------PRICES----------------
  Future<List<ApiPrice>> getAllPrices() async {
    try {
      final prices = await _sqlite.query(tablePrices);

      return prices.map((e) => ApiPrice.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  // //^----------STORAGES----------------
  // List<Storage> getAllStorages() {
  //   try {
  //     final obStorages = _store.box<ObStorage>().getAll();

  //     return obStorages.map((e) => Storage.fromObStorage(e)).toList();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // //^----------BARCODES----------------
  // List<Barcode> getAllBarcodes() {
  //   try {
  //     final obStorages = _store.box<ObBarocde>().getAll();

  //     return obStorages.map((e) => Barcode.fromObPrice(e)).toList();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  //^----------COUNTERPARTY----------------
  Future<List<ApiContract>> getAllContract() async {
    try {
      final counterparty = await _sqlite.query(tableCounterparty);

      return counterparty.map((e) => ApiContract.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------CONTRACT----------------
  Future<List<ApiCounterparty>> getAllCounterparty() async {
    try {
      final contract = await _sqlite.query(tableContract);

      return contract.map((e) => ApiCounterparty.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------DISCOUNT----------------
  Future<List<ApiDiscount>> getAllDiscount() async {
    try {
      final discount = await _sqlite.query(tableDiscount);

      return discount.map((e) => ApiDiscount.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------Unit----------------
  Future<List<ApiUnit>> getAllUnit() async {
    try {
      final units = await _sqlite.query(tableUnit);

      return units.map((e) => ApiUnit.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------UnitClassificator----------------
  Future<List<UnitClassifier>> getAllUnitClassificator() async {
    try {
      final units = await _sqlite.query(tableUnitClassificator);

      return units.map((e) => UnitClassifier.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  //!------------------------------------------------------------------------
  void setNewRows(List<Map<String, dynamic>> data, String tableName) async {
    try {
      await _sqlite.transaction((txn) async {
        Batch batch = txn.batch();

        for (var item in data) {
          batch.insert(tableName, item,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }

        await batch.commit(noResult: true);
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
