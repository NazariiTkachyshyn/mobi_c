import 'package:get_it/get_it.dart';
import 'package:mobi_c/models/counterparty.dart';
import 'package:sqflite/sqflite.dart';

class SelectCounterpartyClient {
  final sqlite = GetIt.I.get<Database>();

  Future<List<Counterparty>> getAll() async {
    try {
      final counterparty = await sqlite.query('counterparty');
      return counterparty.map((e) => Counterparty.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Counterparty>> getCounterpartys(String value) async {
    try {
      final counterparty = await sqlite.query('counterparty',
          where:
              'НаименованиеПолное like "%$value%" or Description like "%$value%"');
      return counterparty.map((e) => Counterparty.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
