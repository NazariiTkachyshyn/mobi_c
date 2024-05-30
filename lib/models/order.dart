import 'package:equatable/equatable.dart';
import 'package:mobi_c/common/constants/key_const.dart';
import 'package:mobi_c/models/models.dart';

class Order extends Equatable {
  final DateTime? date;
  final DateTime? shipmentDate;
  final String counterpartyKey;
  final String partnerKey;
  final String storageKey;
  final String organization;
  final String contractKey;
  final String comment;
  final List<OrderNom> goods;

  const Order(
      {required this.date,
      required this.shipmentDate,
      required this.counterpartyKey,
      required this.partnerKey,
      this.storageKey = KeyConst.storageKey,
      required this.contractKey,
      this.organization = "49b22f0e-2258-11e1-b864-002354e1ef1c",
      required this.comment,
      required this.goods});

  Order copyWith({
    DateTime? date,
    DateTime? shipmentDate,
    String? counterpartyKey,
    String? partnerKey,
    String? ofertaKey,
    String? contractKey,
    String? storageKey,
    String? organization,
    String? comment,
    List<OrderNom>? goods,
  }) {
    return Order(
        date: date ?? this.date,
        shipmentDate: shipmentDate ?? this.shipmentDate,
        counterpartyKey: counterpartyKey ?? this.counterpartyKey,
        partnerKey: partnerKey ?? this.partnerKey,
        storageKey: storageKey ?? this.storageKey,
        organization: organization ?? this.organization,
        comment: comment ?? this.comment,
        goods: goods ?? this.goods,
        contractKey: contractKey ?? this.contractKey);
  }

  Map<String, dynamic> toJson(List<Map<String, dynamic>> products) {
    return {
      'Date': (date ?? DateTime.now()).toIso8601String(),
      'ЖелаемаяДатаОтгрузки': (date ?? DateTime.now()).toIso8601String(),
      "ДатаОтгрузки": (date ?? DateTime.now()).toIso8601String(),
      "Posted": false,
      "DeletionMark": false,
      'Контрагент_Key': counterpartyKey,
      'Партнер_Key': partnerKey,
      'Склад_Key': KeyConst.storageKey,
      'ЦенаВключаетНДС': true,
      'АвторасчетНДС': true,
      'Статус': "КОбеспечению",
      "ДоговорКонтрагента_Key": contractKey,
      'ХозяйственнаяОперация': "РеализацияКлиенту",
      'ДокументОснование_Type': "StandardODATA.Undefined",
      'Согласован': false,
      "СуммаДокумента": products.fold(0.0, (a, b) => a + b['Цена']),
      'Организация_Key': KeyConst.organizationKey,
      'Комментарий': comment,
      'Товары': products
    };
  }

  static const empty = Order(
      date: null,
      shipmentDate: null,
      counterpartyKey: '',
      partnerKey: '',
      storageKey: '',
      organization: '',
      comment: '',
      goods: [],
      contractKey: "");

  @override
  List<Object?> get props => [
        date,
        shipmentDate,
        counterpartyKey,
        partnerKey,
        storageKey,
        organization,
        comment,
        goods,
        contractKey
      ];
}










// var a = {
//         "Date": DateTime.now().toIso8601String(),
//         "Posted": false,
//         "DeletionMark": false,
//         "Контрагент_Key": kontagentId,
//         "Партнер_Key": kontagentId,
//         "Соглашение_Key": oferta,
//         "Склад_Key": storageId,
//         "ЖелаемаяДатаОтгрузки": DateTime.now().toIso8601String(),
//         "ДатаОтгрузки": DateTime.now().toIso8601String(),
//         "ЦенаВключаетНДС": true,
//         "АвторасчетНДС": true,
//         "Статус": "КОбеспечению",
//         "ХозяйственнаяОперация": "РеализацияКлиенту",
//         "ДокументОснование_Type": "StandardODATA.Undefined",
//         "Согласован": false,
//         "Организация_Key": "49b22f0e-2258-11e1-b864-002354e1ef1c",
//         "Товары": goodsList
//       }

 
// var b = {
//       "LineNumber": "$lineNumper",
//       "Номенклатура_Key": nom.nomId,
//       "Склад_Key": nom.storageId,
//       // "Упаковка_Key": nom.packId,
//       "КоличествоУпаковок": nom.count,
//       "Количество": nom.count,
//       "Цена": nom.price,
//       "СтавкаНДС": "НДС20",
//       "ВидЦены_Key": priceType,
//       "ВариантОбеспечения": "Отгрузить"
//     }

