import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final DateTime date;
  final DateTime preferredShippingDate;
  final DateTime shippingDate;
  final String counterpartyRef;
  final bool posted;
  final bool deleteionMark;
  final String oferta;
  final String storageKey;
  final bool nds;
  final bool autoCalcNds;
  final String status;
  final String operation;
  final String documentBaseType;
  final bool agreed;
  final String organizationKey;
  final List<Product> products;

  const Order(
      {required this.date,
      required this.preferredShippingDate,
      required this.shippingDate,
      required this.counterpartyRef,
      required this.posted,
      required this.deleteionMark,
      required this.oferta,
      required this.storageKey,
      required this.nds,
      required this.autoCalcNds,
      required this.status,
      required this.operation,
      required this.documentBaseType,
      required this.agreed,
      required this.organizationKey,
      required this.products});

  @override
  List<Object?> get props => [
        date,
        preferredShippingDate,
        shippingDate,
        counterpartyRef,
        posted,
        deleteionMark,
        oferta,
        storageKey,
        nds,
        autoCalcNds,
        status,
        operation,
        documentBaseType,
        agreed,
        organizationKey,
        products
      ];

  Map<String, dynamic> toJson(Order order) => {
        "Date": date,
        "Posted": posted,
        "DeletionMark": deleteionMark,
        "Контрагент_Key": counterpartyRef,
        "Партнер_Key": counterpartyRef,
        "Соглашение_Key": oferta,
        "Склад_Key": storageKey,
        "ЖелаемаяДатаОтгрузки": preferredShippingDate,
        "ДатаОтгрузки": shippingDate,
        "ЦенаВключаетНДС": nds,
        "АвторасчетНДС": autoCalcNds,
        "Статус": status,
        "ХозяйственнаяОперация": operation,
        "ДокументОснование_Type": documentBaseType,
        "Согласован": agreed,
        "Организация_Key": organizationKey,
        "Товары": products.map((e) => e.toJson()).toList()
      };
}

class Product extends Equatable {
  final String lineNumber;
  final String nomKey;
  final String storageKey;
  final int packCount;
  final int count;
  final String price;
  final String ndsRate;
  final String priceTypeKey;
  final String optionProvision;

  const Product(
      {required this.lineNumber,
      required this.nomKey,
      required this.storageKey,
      required this.packCount,
      required this.count,
      required this.price,
      required this.ndsRate,
      required this.priceTypeKey,
      required this.optionProvision});

  Map<String, dynamic> toJson() => {
        "LineNumber": lineNumber,
        "Номенклатура_Key": nomKey,
        "Склад_Key": storageKey,
        "КоличествоУпаковок": packCount,
        "Количество": count,
        "Цена": price,
        "СтавкаНДС": ndsRate,
        "ВидЦены_Key": priceTypeKey,
        "ВариантОбеспечения": optionProvision
      };
  @override
  List<Object?> get props => [
        lineNumber,
        nomKey,
        storageKey,
        packCount,
        count,
        price,
        ndsRate,
        priceTypeKey,
        optionProvision
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

