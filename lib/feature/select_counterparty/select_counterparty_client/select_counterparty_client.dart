import 'package:get_it/get_it.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/counterparty.dart';

class SelectCounterpartyClient {
  final _store = GetIt.I.get<Store>();

  List<Counterparty> getAll() {
    try {
      return _store.box<Counterparty>().getAll();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Counterparty>> getCounterpartys(String value) async {
    try {
      final loverCaseValue = value.toLowerCase();
      return _store
          .box<Counterparty>()
          .query(Counterparty_.lowerCaseDescription
              .contains(loverCaseValue)
              .and(Counterparty_.lowerCaseFullDescription
                  .equals(loverCaseValue)))
          .build()
          .findAsync();
    } catch (e) {
      throw Exception(e);
    }
  }
}
