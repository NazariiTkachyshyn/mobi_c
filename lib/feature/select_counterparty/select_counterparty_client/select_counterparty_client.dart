import 'package:get_it/get_it.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

class SelectCounterpartyClient {
  final _store = GetIt.I.get<Store>();

  Future<List<Counterparty>> getCounterpartys(String value) async {
    try {
      final loverCaseValue = value.toLowerCase();

      final query = _store
          .box<Counterparty>()
          .query(Counterparty_.searchField.contains(loverCaseValue))
          .build()
        ..limit = 50;
      return query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Counterparty>> getFolders() async {
    try {
      final query = _store
          .box<Counterparty>()
          .query(Counterparty_.isFolder.equals(true))
          .build();
      return query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Counterparty>> getByParentKey(
      String parentKey, int offset) async {
    try {
      final isEqParentKey = parentKey.isNotEmpty
          ? Counterparty_.parentKey.equals(parentKey)
          : Counterparty_.parentKey.notEquals('');
      final query = _store
          .box<Counterparty>()
          .query(isEqParentKey.and(Counterparty_.isFolder.equals(false)))
          .order(Counterparty_.description)
          .build()
        ..limit = 30
        ..offset = offset;

      return await query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Counterparty>> searchInFolder(
    String value,
    String parentKey,
  ) async {
    final valueList = value.split(' ');

    final isEqParentKey = parentKey.isNotEmpty
        ? Counterparty_.parentKey.equals(parentKey)
        : Counterparty_.parentKey.notEquals('');
    final contains = valueList.length > 1
        ? Counterparty_.searchField
            .contains(valueList[0].toLowerCase())
            .and(Counterparty_.searchField.contains(valueList[1].toLowerCase()))
        : Counterparty_.searchField.contains(valueList[0].toLowerCase());
    try {
      final query = _store
          .box<Counterparty>()
          .query(contains
              .and(Counterparty_.isFolder.equals(false))
              .and(isEqParentKey))
          .order(Counterparty_.description)
          .build()
        ..limit = 50;
      return await query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }
    Future<List<ClientRoute>> getRoutes() async {
    try {
      final query = _store.box<ClientRoute>().query().build();
      return query.findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }
}
