import 'package:mobi_c/common/constants/table_named.dart';
import 'package:mobi_c/models/models.dart';

import 'package:sqflite/sqflite.dart';

class DataSyncDbClient {
  final Database _sqlite;

  DataSyncDbClient({required Database sqlite}) : _sqlite = sqlite;

  //^----------NOMENKLATURA----------------
  Future<List<Nom>> getAllNoms() async {
    try {
      final noms = await _sqlite.query(tableNoms);

      return noms.map((e) => Nom.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------PRICES----------------
  Future<List<Price>> getAllPrices() async {
    try {
      final prices = await _sqlite.query(tablePrices);

      return prices.map((e) => Price.fromJson(e)).toList();
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
  Future<List<Contract>> getAllContract() async {
    try {
      final counterparty = await _sqlite.query(tableCounterparty);

      return counterparty.map((e) => Contract.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------CONTRACT----------------
  Future<List<Counterparty>> getAllCounterparty() async {
    try {
      final contract = await _sqlite.query(tableContract);

      return contract.map((e) => Counterparty.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------DISCOUNT----------------
  Future<List<Discount>> getAllDiscount() async {
    try {
      final discount = await _sqlite.query(tableDiscount);

      return discount.map((e) => Discount.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  //!------------------------------------------------------------------------
  void setNewRows(List<Map<String, dynamic>> data, String tableName) async {
    try {
      Batch batch = _sqlite.batch();

      for (var item in data) {
        batch.insert(tableName, item,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
    } catch (e) {
      throw Exception(e);
    }
  }
}
