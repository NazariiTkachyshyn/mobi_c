import 'package:mobi_c/models/counterparty.dart';
import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObCounterparty {
  @Id()
  int id;
  String? refKey;
  String? description;
  String? descriptionLower;
  String? mainCounterpartyKey;
  String? fullDescription;
  String? fullDescriptionLower;
  String? partnerKey;

  ObCounterparty(
      {required this.refKey,
      required this.description,
      required this.descriptionLower,
      required this.mainCounterpartyKey,
      required this.fullDescription,
      required this.fullDescriptionLower,
      required this.partnerKey,
      this.id = 0});

  factory ObCounterparty.fromJson(Map<String, dynamic> json) => ObCounterparty(
        refKey: json['Ref_Key'] ?? '',
        mainCounterpartyKey: json['ГоловнойКонтрагент_Key'] ?? '',
        description: ((json['Description'] ?? '') as String).toLowerCase(),
        descriptionLower: json['Description'] ?? '',
        fullDescription: json['НаименованиеПолное'] ?? '',
        partnerKey: json['Партнер_Key'] ?? '',
        fullDescriptionLower:
            ((json['НаименованиеПолное'] ?? '') as String).toLowerCase(),
      );

  factory ObCounterparty.fromApi(Counterparty counterparty) => ObCounterparty(
      refKey: counterparty.refKey,
      mainCounterpartyKey: counterparty.mainCounterpartyKey,
      description: counterparty.description,
      descriptionLower: counterparty.description.toLowerCase(),
      fullDescription: counterparty.fullDescription,
      fullDescriptionLower: counterparty.fullDescription.toLowerCase(),
      partnerKey: counterparty.partnerKey);
}
