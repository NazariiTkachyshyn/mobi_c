import 'package:mobi_c/services/data_sync_service/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Contract {
  @Id()
  int id;
  String refKey;
  String description;
  String ownerKey;
  String organizationKey;

  Contract(
      {required this.refKey,
      required this.description,
      required this.ownerKey,
      required this.organizationKey,
      this.id = 0});

  factory Contract.fromApi(SyncContract contract) => Contract(
      refKey: contract.refKey,
      description: contract.description,
      ownerKey: contract.ownerKey,
      organizationKey: contract.organizationKey);
}
