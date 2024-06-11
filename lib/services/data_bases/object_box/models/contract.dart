import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObContract {
  @Id()
  int id;
  final String refKey;
  final String description;
  final String ownerKey;
  final String organizationKey;

  ObContract(
      {required this.refKey,
        required this.description,
        required this.ownerKey,
        required this.organizationKey,
        this.id = 0});

  factory ObContract.fromApi(ApiContract contract) => ObContract(
      refKey: contract.refKey,
      description: contract.description,
      ownerKey: contract.ownerKey,
      organizationKey: contract.organizationKey);
}
