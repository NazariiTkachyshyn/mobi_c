import 'package:mobi_c/models/models.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/object_box/models/models.dart';
import 'package:mobi_c/services/object_box/models/ob_counterparty.dart';

class DataSyncDbClient {
  final Store _store;

  DataSyncDbClient({required Store store}) : _store = store;

  //^----------NOMENKLATURA----------------
  List<Nom> getAllNoms() {
    try {
      final obNom = _store.box<ObNom>().getAll();

      return obNom.map((e) => Nom.fromObNom(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setNewNoms(Set<Nom> noms) async {
    try {
      await _store
          .box<ObNom>()
          .putManyAsync(noms.map((e) => ObNom.fromApi(e)).toList());
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------PRICES----------------
  List<Price> getAllPrices() {
    try {
      final obPrice = _store.box<ObPrice>().getAll();

      return obPrice.map((e) => Price.fromObPrice(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setNewPrices(Set<Price> prices) async {
    try {
      await _store
          .box<ObPrice>()
          .putManyAsync(prices.map((e) => ObPrice.fromApi(e)).toList());
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
