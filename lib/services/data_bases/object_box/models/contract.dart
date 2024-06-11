import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Contract {
  @Id()
  int id;
  final String refKey;
  final String description;
  final String ownerKey;
  final String organizationKey;

  Contract(
      {required this.refKey,
        required this.description,
        required this.ownerKey,
        required this.organizationKey,
        this.id = 0});

  factory Contract.fromApi(ApiContract contract) => Contract(
      refKey: contract.refKey,
      description: contract.description,
      ownerKey: contract.ownerKey,
      organizationKey: contract.organizationKey);
}
