import 'package:equatable/equatable.dart';

import '../../data_base/object_box/models/contract.dart';

class SyncContract extends Equatable {
  final String refKey;
  final String description;
  final String ownerKey;
  final String organizationKey;

  const SyncContract({
    required this.refKey,
    required this.description,
    required this.organizationKey,
    required this.ownerKey,
  });

  factory SyncContract.fromJson(Map<String, dynamic> json) => SyncContract(
        refKey: json['Ref_Key'] ?? '',
        ownerKey: json['Owner_Key'] ?? '',
        organizationKey: json['Организация_Key'] ?? '',
        description: json['Description'] ?? '',
      );

  factory SyncContract.fromOb(Contract contract) => SyncContract(
        refKey: contract.refKey,
        description: contract.description,
        ownerKey: contract.ownerKey,
        organizationKey: contract.organizationKey,
      );



  static const empty = SyncContract(
    refKey: '',
    description: '',
    ownerKey: '',
    organizationKey: '',
  );

  @override
  List<Object?> get props => [refKey, description, ownerKey, organizationKey];
}
