import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobi_c/common/func.dart';
import 'package:mobi_c/feature/create_order/create_order_repo/create_order_repo.dart';
import 'package:mobi_c/repository/config_repo/config_repo.dart';
import 'package:mobi_c/services/data_base/object_box/models/PKO.dart';
import 'package:mobi_c/services/data_base/object_box/object_box.dart';
import 'package:mobi_c/services/data_sync_service/models/order.dart';
import 'package:mobi_c/services/data_base/object_box/models/models.dart';
import 'package:http/http.dart' as http;
part 'create_pko_state.dart';

class CreatePKOCubit extends Cubit<CreatePKOState> {
  CreatePKOCubit(this._createOrderRepo)
      : super(CreatePKOState(selectedDate: DateTime(1), contractKey: ''));

  final CreateOrderRepo _createOrderRepo;

  void selectDatetime(DateTime? date) {
    emit(state.copyWith(selectedDate: date));
  }

  void updateDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  Future<void> selectCounterparty(Counterparty counterparty) async {
    emit(state.copyWith(contractKey: ''));

    emit(state.copyWith(
        counterparty: counterparty,
        order: state.order.copyWith(
            counterpartyKey: counterparty.refKey,
            partnerKey: counterparty.refKey)));
    await getContracts(counterparty.refKey);
  }

  Future<void> getContracts(String ownerKey) async {
    try {
      final contracts = await _createOrderRepo.getContracts(ownerKey);
      emit(state.copyWith(
          order: state.order.copyWith(
            contractKey: contracts.first.refKey,
          ),
          contracts: contracts,
          status: CreatePKOStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: CreatePKOStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> getDiscount(String discountRecipient) async {
    try {
      final discount = await _createOrderRepo.getDiscount(discountRecipient);
      emit(state.copyWith(discount: discount, status: CreatePKOStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: CreatePKOStatus.failure, errorMessage: e.toString()));
    }
  }

  void changeContract(String contractKey) {
    emit(state.copyWith(order: state.order.copyWith(contractKey: contractKey)));
  }

  void setSum(double value) {
    emit(state.copyWith(sum: value));
  }

  double getSum() {
    return state.sum;
  }

  String getDescription() {
    return extractCity(state.counterparty.description);
  }

  String extractCity(String input) {
    final regex = RegExp(r'\((.*?)\)');
    final matches = regex.allMatches(input);
    if (matches.isNotEmpty) {
      return matches.first.group(1) ?? '';
    } else {
      return '';
    }
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return formatter.format(dateTime);
  }

  bool counterPartyIsEmpty() {
    return state.counterparty == Counterparty.empty;
  }

  Map<String, dynamic> toJson() {
    return {
      "DeletionMark": false,
      "Date": state.selectedDate!.toIso8601String(),
      "Posted": true,
      "Организация_Key": Config.organizationKey,
      "Касса_Key": Config.kasa.ref,
      "Подразделение_Key": "00000000-0000-0000-0000-000000000000",
      "ВидОперации": "ОплатаПокупателя",
      "Контрагент": state.counterparty.refKey,
      "Контрагент_Type": "StandardODATA.Catalog_Контрагенты",
      "ДоговорКонтрагента_Key": state.contracts[0].refKey,
      "ВалютаДокумента_Key": "7fc302bf-2248-11e1-b864-002354e1ef1c",
      "СуммаДокумента": state.sum.toString(),
      "ПринятоОт": state.counterparty.fullDescription,
      "ОтраженоВОперУчете": true,
      "Оплачено": true,
      "Ответственный_Key": Config.responsibleUser,
      "Комментарий": state.comment,
      "ОтражатьВУправленческомУчете": true,
      "ОтражатьВБухгалтерскомУчете": true,
      "СтатьяДвиженияДенежныхСредств_Key":
          "eb3df34e-24c9-46b6-9967-3ab8deacf6d3",
      "СчетОрганизации_Key": "00000000-0000-0000-0000-000000000000",
      "ОтражатьВНалоговомУчете": true,
      "РасшифровкаПлатежа": [
        {
          "LineNumber": "1",
          "ДоговорКонтрагента_Key": state.counterparty.refKey,
          "КурсВзаиморасчетов": "1",
          "СуммаПлатежа": state.sum.toString(),
          "КратностьВзаиморасчетов": "1",
          "СуммаВзаиморасчетов": state.sum.toString(),
          "СтавкаНДС": "",
          "СуммаНДС": "0",
          "ЗаТару": false,
        }
      ],
    };
  }

  Future<void> createPKO() async {
    final url = Uri.parse(
        "http://192.168.2.50:81/virok_test/odata/standard.odata/Document_ПриходныйКассовыйОрдер?\$format=json");
    const String username = 'dt';
    const String pass = 'DT20Group';
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$pass'))}';
    final headers = {
      'Authorization': basicAuth,
      "Accept": "application/json",
      "Accept-Charset": "UTF-8",
      "Content-Type": "application/json",
    };
    var pko = toJson();
    final body = jsonEncode(pko);

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final response = await http.post(url, headers: headers, body: body);
        if (response.statusCode == 201) {
          print('Pko hac been sent');
        } else {
          throw Exception(response.body);
        }
      } else {
        final objectBox = GetIt.I<ObjectBox>();
        final pkoBox = objectBox.store.box<PKO>();
        await pkoBox.putAsync(PKO.fromJson(pko));
      }
    } on SocketException catch (_) {
      final objectBox = GetIt.I<ObjectBox>();
      final pkoBox = objectBox.store.box<PKO>();
      await pkoBox.putAsync(PKO.fromJson(pko));
    } catch (e) {
      throw Exception('Failed to create PKO: $e');
    }
  }
}
