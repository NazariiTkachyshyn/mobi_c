import 'package:objectbox/objectbox.dart';
import 'package:mobi_c/repository/config_repo/config_repo.dart';

@Entity()
class Order {
  @Id()
  int id;
  DateTime? date;
  DateTime? shipmentDate;
  String counterpartyKey;
  String partnerKey;
  String storageKey;
  String organization;
  String contractKey;
  String comment;
  bool pickup;

  Order({
    required this.date,
    required this.shipmentDate,
    required this.counterpartyKey,
    required this.partnerKey,
    required this.storageKey,
    required this.organization,
    required this.contractKey,
    required this.comment,
    required this.pickup,
    this.id = 0,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      date: DateTime.parse(json['Date']),
      shipmentDate: json['ЖелаемаяДатаОтгрузки'] != null
          ? DateTime.parse(json['ЖелаемаяДатаОтгрузки'])
          : null,
      counterpartyKey: json['Контрагент_Key'],
      partnerKey: json['Партнер_Key'],
      storageKey: json['Склад_Key'] ?? '',
      contractKey: json['Соглашение_Key'] ?? '',
      organization: json['Организация_Key'] ?? '',
      comment: json['Комментарий'] ?? '',
      pickup: json['Самовивіз'] ?? false,
    );
  }

  Map<String, dynamic> toJson(List<Map<String, dynamic>> products) {
    return {
      'Date': (date ?? DateTime.now()).toIso8601String(),
      "Posted": false,
      "DeletionMark": false,
      "ВалютаДокумента_Key": Config.currencyKey,
      'Контрагент_Key': counterpartyKey,
      'Партнер_Key': partnerKey,
      'ЦенаВключаетНДС': true,
      'АвторасчетНДС': true,
      'Статус': "КОбеспечению",
      "ДоговорКонтрагента_Key": contractKey,
      'ХозяйственнаяОперация': "РеализацияКлиенту",
      'ДокументОснование_Type': "StandardODATA.Undefined",
      "КратностьВзаиморасчетов": "1",
      "Самовивіз": pickup,
      'Согласован': false,
      "СкладГруппа": Config.storageKey,
      "Ответственный_Key": Config.responsibleUser,
      "СкладГруппа_Type": "StandardODATA.Catalog_Склады",
      "СуммаДокумента": products.fold(0.0, (a, b) => a + b['Цена']),
      'Организация_Key': Config.organizationKey,
      'Комментарий': comment,
      'Товары': products
    };
  }

  static final empty = Order(
    date: null,
    shipmentDate: null,
    counterpartyKey: '',
    partnerKey: '',
    storageKey: '',
    organization: '',
    comment: '',
    pickup: false,
    contractKey: '',
  );

  @override
  String toString() {
    return 'Order{id: $id, date: $date, shipmentDate: $shipmentDate, '
        'counterpartyKey: $counterpartyKey, partnerKey: $partnerKey, '
        'storageKey: $storageKey, organization: $organization, '
        'contractKey: $contractKey, comment: $comment, pickup: $pickup}';
  }
}
