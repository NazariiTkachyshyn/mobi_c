import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/object_box/models/ob_counterparty.dart';

class Counterparty extends Equatable {
  final String refKey;
  final String description;
  final String mainCounterpartyKey;
  final String partnerKey;
  final String fullDescription;

  const Counterparty(
      {required this.refKey,
      required this.description,
      required this.partnerKey,
      required this.mainCounterpartyKey,
      required this.fullDescription});

  factory Counterparty.fromJson(Map<String, dynamic> json) => Counterparty(
      refKey: json['Ref_Key'] ?? '',
      mainCounterpartyKey: json['ГоловнойКонтрагент_Key'] ?? '',
      partnerKey: json['Партнер_Key'] ?? '',
      description: json['Description'] ?? '',
      fullDescription: json['НаименованиеПолное'] ?? '');

  factory Counterparty.fromObCounterparty(ObCounterparty counterparty) =>
      Counterparty(
          refKey: counterparty.refKey ?? '',
          mainCounterpartyKey: counterparty.mainCounterpartyKey ?? '',
          partnerKey: counterparty.partnerKey ?? '',
          description: counterparty.description ?? '',
          fullDescription: counterparty.fullDescription ?? '');

  static const empty = Counterparty(
      refKey: '',
      description: '',
      mainCounterpartyKey: '',
      partnerKey: '',
      fullDescription: '');

  @override
  List<Object?> get props =>
      [refKey, description, mainCounterpartyKey, fullDescription, partnerKey];
}
