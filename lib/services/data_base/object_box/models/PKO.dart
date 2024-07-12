import 'dart:convert';
import 'package:objectbox/objectbox.dart';

@Entity()
class PKO {
  @Id()
  int id;

  bool deletionMark;
  String date;
  bool posted;
  String organizationKey;
  String kasaKey;
  String subdivisionKey;
  String operationType;
  String counterpartyKey;
  String counterpartyType;
  String contractKey;
  String currencyKey;
  String documentSum;
  String acceptedFrom;
  bool reflectedInOperAccount;
  bool paid;
  String responsibleUserKey;
  String comment;
  bool reflectedInManageAccount;
  bool reflectedInAccAccount;
  String movementArticleKey;
  String organizationAccountKey;
  bool reflectedInTaxAccount;
  String paymentDecryption;

  PKO({
    this.id = 0,
    required this.deletionMark,
    required this.date,
    required this.posted,
    required this.organizationKey,
    required this.kasaKey,
    required this.subdivisionKey,
    required this.operationType,
    required this.counterpartyKey,
    required this.counterpartyType,
    required this.contractKey,
    required this.currencyKey,
    required this.documentSum,
    required this.acceptedFrom,
    required this.reflectedInOperAccount,
    required this.paid,
    required this.responsibleUserKey,
    required this.comment,
    required this.reflectedInManageAccount,
    required this.reflectedInAccAccount,
    required this.movementArticleKey,
    required this.organizationAccountKey,
    required this.reflectedInTaxAccount,
    required this.paymentDecryption,
  });

  factory PKO.fromJson(Map<String, dynamic> json) {
    return PKO(
      deletionMark: json['DeletionMark'],
      date: json['Date'],
      posted: json['Posted'],
      organizationKey: json['Организация_Key'],
      kasaKey: json['Касса_Key'],
      subdivisionKey: json['Подразделение_Key'],
      operationType: json['ВидОперации'],
      counterpartyKey: json['Контрагент'],
      counterpartyType: json['Контрагент_Type'],
      contractKey: json['ДоговорКонтрагента_Key'],
      currencyKey: json['ВалютаДокумента_Key'],
      documentSum: json['СуммаДокумента'],
      acceptedFrom: json['ПринятоОт'],
      reflectedInOperAccount: json['ОтраженоВОперУчете'],
      paid: json['Оплачено'],
      responsibleUserKey: json['Ответственный_Key'],
      comment: json['Комментарий'],
      reflectedInManageAccount: json['ОтражатьВУправленческомУчете'],
      reflectedInAccAccount: json['ОтражатьВБухгалтерскомУчете'],
      movementArticleKey: json['СтатьяДвиженияДенежныхСредств_Key'],
      organizationAccountKey: json['СчетОрганизации_Key'],
      reflectedInTaxAccount: json['ОтражатьВНалоговомУчете'],
      paymentDecryption: jsonEncode(json['РасшифровкаПлатежа']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DeletionMark': deletionMark,
      'Date': date,
      'Posted': posted,
      'Организация_Key': organizationKey,
      'Касса_Key': kasaKey,
      'Подразделение_Key': subdivisionKey,
      'ВидОперации': operationType,
      'Контрагент': counterpartyKey,
      'Контрагент_Type': counterpartyType,
      'ДоговорКонтрагента_Key': contractKey,
      'ВалютаДокумента_Key': currencyKey,
      'СуммаДокумента': documentSum,
      'ПринятоОт': acceptedFrom,
      'ОтраженоВОперУчете': reflectedInOperAccount,
      'Оплачено': paid,
      'Ответственный_Key': responsibleUserKey,
      'Комментарий': comment,
      'ОтражатьВУправленческомУчете': reflectedInManageAccount,
      'ОтражатьВБухгалтерскомУчете': reflectedInAccAccount,
      'СтатьяДвиженияДенежныхСредств_Key': movementArticleKey,
      'СчетОрганизации_Key': organizationAccountKey,
      'ОтражатьВНалоговомУчете': reflectedInTaxAccount,
      'РасшифровкаПлатежа': jsonDecode(paymentDecryption),
    };
  }
}
