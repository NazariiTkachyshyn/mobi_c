import 'package:mobi_c/models/models.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import 'package:mobi_c/services/data_bases/object_box/models/ob_counterparty.dart';
import 'package:sqflite/sqflite.dart';

class DataSyncDbClient {
  final Store _store;
  final Database _sqlite;

  DataSyncDbClient({required Store store, required Database sqlite})
      : _store = store,
        _sqlite = sqlite;

  //^----------NOMENKLATURA----------------
  Future<List<Nom>> getAllNoms() async {
    try {
      final noms = await _sqlite.query('noms');

      return noms.map((e) => Nom.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setNewNoms(List<Map<String, dynamic>> data) async {
    try {
      Batch batch = _sqlite.batch();

      for (var item in data) {
        batch.insert('noms', item,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------PRICES----------------
  Future<List<Price>> getAllPrices() async{
    try {
      final prices = await _sqlite.query('prices');

      return prices.map((e) => Price.fromSql(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setNewPrices(List<Map<String, dynamic>> data) async {
    try {
   Batch batch = _sqlite.batch();

      for (var item in data) {
        batch.insert('prices', item,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      await batch.commit(noResult: true);
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------STORAGES----------------
  List<Storage> getAllStorages() {
    try {
      final obStorages = _store.box<ObStorage>().getAll();

      return obStorages.map((e) => Storage.fromObStorage(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setNewStorages(Set<Storage> prices) async {
    try {
      await _store
          .box<ObStorage>()
          .putManyAsync(prices.map((e) => ObStorage.fromApi(e)).toList());
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------BARCODES----------------
  List<Barcode> getAllBarcodes() {
    try {
      final obStorages = _store.box<ObBarocde>().getAll();

      return obStorages.map((e) => Barcode.fromObPrice(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setNewBarcodes(Set<Barcode> prices) async {
    try {
      await _store
          .box<ObBarocde>()
          .putManyAsync(prices.map((e) => ObBarocde.fromApi(e)).toList());
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------Counterparty----------------
  List<Counterparty> getAllCounterparty() {
    try {
      final obStorages = _store.box<ObCounterparty>().getAll();

      return obStorages.map((e) => Counterparty.fromObCounterparty(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setNewCounterparty(Set<Counterparty> prices) async {
    try {
      await _store
          .box<ObCounterparty>()
          .putManyAsync(prices.map((e) => ObCounterparty.fromApi(e)).toList());
    } catch (e) {
      throw Exception(e);
    }
  }
}
