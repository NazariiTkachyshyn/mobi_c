import 'package:equatable/equatable.dart';

class ApiCounterparty extends Equatable {
  final String refKey;
  final String description;
  final String mainCounterpartyKey;
  final String partnerKey;
  final String fullDescription;

  const ApiCounterparty(
      {required this.refKey,
      required this.description,
      required this.partnerKey,
      required this.mainCounterpartyKey,
      required this.fullDescription});

  factory ApiCounterparty.fromJson(Map<String, dynamic> json) => ApiCounterparty(
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

  static const empty = ApiCounterparty(
      refKey: '',
      description: '',
      mainCounterpartyKey: '',
      partnerKey: '',
      fullDescription: '');

  @override
  List<Object?> get props =>
      [refKey, description, mainCounterpartyKey, fullDescription, partnerKey];
}
