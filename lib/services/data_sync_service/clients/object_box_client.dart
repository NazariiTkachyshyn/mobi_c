import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/image.dart';
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

  void setNom(List<Nom> noms) async {
    try {
      await _store.box<Nom>().putManyAsync(noms);
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

  void setStorage(List<Storage> storages) async {
    try {
      await _store.box<Storage>().putManyAsync(storages);
    } catch (e) {
      throw Exception(e);
    }
  }


  void setBarcode(List<Barcode> barcodes) async {
    try {
      await _store.box<Barcode>().putManyAsync(barcodes);
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

  void setContract(List<Contract> contracts) async {
    try {
      await _store.box<Contract>().putManyAsync(contracts);
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

  void setCounterparty(List<Counterparty> counterpartys) async {
    try {
      await _store.box<Counterparty>().putManyAsync(counterpartys);
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

  void setDiscount(
    List<Discount> discounts,
  ) async {
    try {
      await _store.box<Discount>().putManyAsync(discounts);
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

  void setUnit(List<Unit> units) async {
    try {
      await _store.box<Unit>().putManyAsync(units);
    } catch (e) {
      throw Exception(e);
    }
  }


  // // //^----------BARCODES----------------
  // Future<List<SyncBarcode>> getAllBarcodes() async {
  //   try {
  //     final res = await _store.box<Barcode>().query().build().findAsync();
  //     return res.map((e) => SyncBarcode.fromOb(e)).toList();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

//^-----------Image-----------------------------

  Future setImages(List<ImageOb> image) async {
    try {
      await _store.box<ImageOb>().putManyAsync(image);
    } catch (e) {
      throw Exception(e);
    }
  }

}
