import 'package:mobi_c/objectbox.g.dart';
import 'package:get_it/get_it.dart';

import '../../../services/data_bases/object_box/models/ob_counterparty.dart';

class SelectCounterpartyClient {
  final db = GetIt.I.get<Store>();

  Future<List<ObCounterparty>> getAll() async {
    try {
      final counterparty = db.box<ObCounterparty>().getAll();
      return counterparty;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ObCounterparty>> getByParendKey(String parentKey) async {
    try {
      final query = db
          .box<ObCounterparty>()
          .query(ObCounterparty_.partnerKey.equals(parentKey))
          .build();
      final counterparty = await query.findAsync();
      return counterparty;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ObCounterparty>> getCounterpartys(String value) async {
    try {
      final query = db
          .box<ObCounterparty>()
          .query(ObCounterparty_.descriptionLower
              .contains(value.toLowerCase())
              .or(ObCounterparty_.fullDescriptionLower
                  .contains(value.toLowerCase())))
          .build();
      final counterparty = await query.findAsync();
      return counterparty;
    } catch (e) {
      throw Exception(e);
    }
  }
}
