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
  String parentKey;
  bool isFolder;

  Counterparty(
      {required this.refKey,
      required this.description,
      required this.mainCounterpartyKey,
      required this.partnerKey,
      required this.fullDescription,
      required this.searchField,
      required this.parentKey,
      required this.isFolder,
      this.id = 0});

  factory Counterparty.fromApi(SyncCounterparty counterparty) => Counterparty(
      refKey: counterparty.refKey,
      description: counterparty.description,
      mainCounterpartyKey: counterparty.mainCounterpartyKey,
      partnerKey: counterparty.partnerKey,
      fullDescription: counterparty.fullDescription,
      searchField: (counterparty.description + counterparty.fullDescription)
          .toLowerCase(),
      parentKey: counterparty.parentKey,
      isFolder: counterparty.isFolder
      );

  static final empty = Counterparty(
      refKey: '',
      description: '',
      mainCounterpartyKey: '',
      partnerKey: '',
      fullDescription: '',
      searchField: '',
      parentKey: '',
      isFolder: false
      );
}
