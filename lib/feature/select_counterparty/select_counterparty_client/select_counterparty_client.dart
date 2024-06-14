import 'package:get_it/get_it.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/counterparty.dart';

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
}
