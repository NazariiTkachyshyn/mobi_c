import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObCounterparty {
  @Id()
  int id;
  final String refKey;
  final String description;
  final String lowerCaseDescription;
  final String mainCounterpartyKey;
  final String partnerKey;
  final String fullDescription;
  final String lowerCaseFullDescription;

  ObCounterparty(
      {required this.refKey,
        required this.description,
        required this.lowerCaseDescription,
        required this.mainCounterpartyKey,
        required this.partnerKey,
        required this.fullDescription,
        required this.lowerCaseFullDescription,
        this.id = 0});

  factory ObCounterparty.fromApi(ApiCounterparty counterparty) => ObCounterparty(
      refKey: counterparty.refKey,
      description: counterparty.description,
      lowerCaseDescription: counterparty.description.toLowerCase(),
      mainCounterpartyKey: counterparty.mainCounterpartyKey,
      partnerKey: counterparty.partnerKey,
      fullDescription: counterparty.fullDescription,
      lowerCaseFullDescription: counterparty.fullDescription.toLowerCase());
}
