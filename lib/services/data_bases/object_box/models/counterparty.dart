import 'package:mobi_c/services/data_sync_service/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Counterparty {
  @Id()
  int id;
  String refKey;
  String description;
  String mainCounterpartyKey;
  String partnerKey;
  String fullDescription;
  String searchField;

  Counterparty(
      {required this.refKey,
      required this.description,
      required this.mainCounterpartyKey,
      required this.partnerKey,
      required this.fullDescription,
      required this.searchField,
      this.id = 0});

  factory Counterparty.fromApi(SyncCounterparty counterparty) => Counterparty(
      refKey: counterparty.refKey,
      description: counterparty.description,
      mainCounterpartyKey: counterparty.mainCounterpartyKey,
      partnerKey: counterparty.partnerKey,
      fullDescription: counterparty.fullDescription,
      searchField: (counterparty.description + counterparty.fullDescription)
          .toLowerCase());

  static final empty = Counterparty(
      refKey: '',
      description: '',
      mainCounterpartyKey: '',
      partnerKey: '',
      fullDescription: '',
      searchField: '');
}
