import 'package:mobi_c/common/constants/key_const.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import 'package:mobi_c/services/data_sync_service/models/models.dart';

class DataSyncObjectBoxClient {
  final Store _store;

  DataSyncObjectBoxClient({required Store store}) : _store = store;

  //^----------NOMENKLATURA----------------
  Future<List<SyncNom>> getAllNoms() async {
    try {
      final res = await _store.box<Nom>().query().build().findAsync();
      return res.map((e) => SyncNom.fromOb(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  int getNomsCount()  {
    try {
      return _store.box<Nom>().count();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setNom(List<Nom> noms) async {
    try {
      await _store.box<Nom>().putManyAsync(noms);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<SyncNom>> getAllNomsByStorage() async {
    try {
      final res = await _store
          .box<Nom>()
          .query(Nom_.storageKey.equals(Key1Const.storageKey))
          .build()
          .findAsync();
      return res.map((e) => SyncNom.fromOb(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  // //^----------STORAGES----------------
  Future<List<SyncStorage>> getAllStorages() async {
    try {
      final res = await _store.box<Storage>().query().build().findAsync();
      return res.map((e) => SyncStorage.fromOb(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setStorage(List<Storage> storages) async {
    try {
      await _store.box<Storage>().putManyAsync(storages);
    } catch (e) {
      throw Exception(e);
    }
  } int getStoragesCount()  {
    try {
      return _store.box<Storage>().count();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------CONTRACT----------------
  Future<List<SyncContract>> getAllContract() async {
    try {
      final res = await _store.box<Contract>().query().build().findAsync();
      return res.map((e) => SyncContract.fromOb(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setContract(List<Contract> contracts) async {
    try {
      await _store.box<Contract>().putManyAsync(contracts);
    } catch (e) {
      throw Exception(e);
    }
  }  int getContractsCount()  {
    try {
      return _store.box<Contract>().count();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------Counterparty----------------
  Future<List<SyncCounterparty>> getAllCounterparty() async {
    try {
      final res = await _store.box<Counterparty>().query().build().findAsync();
      return res.map((e) => SyncCounterparty.fromOb(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setCounterparty(List<Counterparty> counterpartys) async {
    try {
      await _store.box<Counterparty>().putManyAsync(counterpartys);
    } catch (e) {
      throw Exception(e);
    }
  } int getCounterpartysCount()  {
    try {
      return _store.box<Counterparty>().count();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------DISCOUNT----------------
  Future<List<SyncDiscount>> getAllDiscount() async {
    try {
      final res = await _store.box<Discount>().query().build().findAsync();
      return res.map((e) => SyncDiscount.fromOb(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setDiscount(
    List<Discount> discounts,
  ) async {
    try {
      await _store.box<Discount>().putManyAsync(discounts);
    } catch (e) {
      throw Exception(e);
    }
  }  int getDiscountsCount()  {
    try {
      return _store.box<Discount>().count();
    } catch (e) {
      throw Exception(e);
    }
  }

  //^----------Unit----------------
  Future<List<SyncUnit>> getAllUnit() async {
    try {
      final res = await _store.box<Unit>().query().build().findAsync();
      return res.map((e) => SyncUnit.fromOb(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> setUnit(List<Unit> units) async {
    try {
      await _store.box<Unit>().putManyAsync(units);
    } catch (e) {
      throw Exception(e);
    }
  }  int getUnitsCount()  {
    try {
      return _store.box<Unit>().count();
    } catch (e) {
      throw Exception(e);
    }
  }

  deleteAll() {
    _store.box<Nom>().query().build().removeAsync();
    _store.box<Counterparty>().query().build().removeAsync();
    _store.box<Contract>().query().build().removeAsync();
    _store.box<Discount>().query().build().removeAsync();
    _store.box<Unit>().query().build().removeAsync();
  }
}
