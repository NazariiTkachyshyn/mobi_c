import 'dart:convert';
import 'package:objectbox/objectbox.dart';

@Entity()
class FullOrder {
  @Id()
  int id;

  String date;
  bool posted;
  bool deletionMark;
  String currencyKey;
  String counterpartyKey;
  String partnerKey;
  bool priceIncludesVAT;
  bool autoVATCalculation;
  String status;
  String contractKey;
  String economicOperation;
  String baseDocumentType;
  String reciprocity;
  bool pickup;
  bool agreed;
  String storageGroup;
  String responsibleUser;
  String storageGroupType;
  double documentAmount;
  String organizationKey;
  String comment;
  List<Map<String, dynamic>> productsJson; // Зберігаємо продукти як JSON-рядок

  FullOrder({
    this.id = 0,
    required this.date,
    required this.posted,
    required this.deletionMark,
    required this.currencyKey,
    required this.counterpartyKey,
    required this.partnerKey,
    required this.priceIncludesVAT,
    required this.autoVATCalculation,
    required this.status,
    required this.contractKey,
    required this.economicOperation,
    required this.baseDocumentType,
    required this.reciprocity,
    required this.pickup,
    required this.agreed,
    required this.storageGroup,
    required this.responsibleUser,
    required this.storageGroupType,
    required this.documentAmount,
    required this.organizationKey,
    required this.comment,
    List<Map<String, dynamic>> products = const [],
  }) : productsJson = [];

  factory FullOrder.fromJson(Map<String, dynamic> json) {
    return FullOrder(
      date: json['Date'],
      posted: json['Posted'],
      deletionMark: json['DeletionMark'],
      currencyKey: json['ВалютаДокумента_Key'],
      counterpartyKey: json['Контрагент_Key'],
      partnerKey: json['Партнер_Key'],
      priceIncludesVAT: json['ЦенаВключаетНДС'],
      autoVATCalculation: json['АвторасчетНДС'],
      status: json['Статус'],
      contractKey: json['ДоговорКонтрагента_Key'],
      economicOperation: json['ХозяйственнаяОперация'],
      baseDocumentType: json['ДокументОснование_Type'],
      reciprocity: json['КратностьВзаиморасчетов'],
      pickup: json['Самовивіз'],
      agreed: json['Согласован'],
      storageGroup: json['СкладГруппа'],
      responsibleUser: json['Ответственный_Key'],
      storageGroupType: json['СкладГруппа_Type'],
      documentAmount: json['СуммаДокумента'],
      organizationKey: json['Организация_Key'],
      comment: json['Комментарий'],
      products: List<Map<String, dynamic>>.from(jsonDecode(json['Товары'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Date': date,
      'Posted': posted,
      'DeletionMark': deletionMark,
      'ВалютаДокумента_Key': currencyKey,
      'Контрагент_Key': counterpartyKey,
      'Партнер_Key': partnerKey,
      'ЦенаВключаетНДС': priceIncludesVAT,
      'АвторасчетНДС': autoVATCalculation,
      'Статус': status,
      'ДоговорКонтрагента_Key': contractKey,
      'ХозяйственнаяОперация': economicOperation,
      'ДокументОснование_Type': baseDocumentType,
      'КратностьВзаиморасчетов': reciprocity,
      'Самовивіз': pickup,
      'Согласован': agreed,
      'СкладГруппа': storageGroup,
      'Ответственный_Key': responsibleUser,
      'СкладГруппа_Type': storageGroupType,
      'СуммаДокумента': documentAmount,
      'Организация_Key': organizationKey,
      'Комментарий': comment,
      'Товары': productsJson,
    };
  }

  // List<Map<String, dynamic>> get products =>
  //     List<Map<String, dynamic>>.from(jsonDecode(productsJson));
}
