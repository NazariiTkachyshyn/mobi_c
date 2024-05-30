import 'package:equatable/equatable.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'Ref_Key': refKey,
      'ГоловнойКонтрагент_Key': mainCounterpartyKey,
      'Партнер_Key': partnerKey,
      'Description': description,
      'НаименованиеПолное': fullDescription,
    };
  }

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
