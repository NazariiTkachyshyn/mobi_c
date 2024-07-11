import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:mobi_c/common/func.dart';
import 'package:mobi_c/feature/create_order/create_order_repo/create_order_repo.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/repository/config_repo/config_repo.dart';
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

  Future<void> sendPostRequest() async {
    final url = Uri.parse(
        "http://192.168.2.50:81/virok_test/odata/standard.odata/Document_ПриходныйКассовыйОрдер?\$format=json");
    // "${Config.odataPath}/Document_ПриходныйКассовыйОрдер?\$format=json");
    const String username = 'dt';
    const String pass = 'DT20Group';
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$pass'))}';
    final headers = {
      'Authorization': basicAuth,
    };
    final body = jsonEncode(toJson());

    // ignore: unused_local_variable
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
  }
}
