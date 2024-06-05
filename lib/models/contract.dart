import 'package:equatable/equatable.dart';

class Contract extends Equatable {
  final String refKey;
  final String description;
  final String ownerKey;
  final String organizationKey;

  const Contract({
    required this.refKey,
    required this.description,
    required this.organizationKey,
    required this.ownerKey,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        refKey: json['Ref_Key'] ?? '',
        ownerKey: json['Owner_Key'] ?? '',
        organizationKey: json['Организация_Key'] ?? '',
        description: json['Description'] ?? '',
      );

  Map<String, dynamic> toJson() {
    return {
      'Ref_Key': refKey,
      'Owner_Key': ownerKey,
      'Организация_Key': organizationKey,
      'Description': description,
    };
  }

  static const empty = Contract(
    refKey: '',
    description: '',
    ownerKey: '',
    organizationKey: '',
  );

  @override
  List<Object?> get props => [refKey, description, ownerKey, organizationKey];
}