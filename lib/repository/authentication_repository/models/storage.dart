import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/data_base/object_box/models/config.dart';

class Storage extends Equatable {
  final String refKey;
  final String description;

  const Storage({required this.refKey, required this.description});

  factory Storage.fromJson(Map<String, dynamic> json) => Storage(
      refKey: json['Ref_Key'] ?? '', description: json['Description'] ?? '');

        factory Storage.fromStorageOb(StorageOb storageOb) {
    return Storage(
      refKey: storageOb.refKey,
      description: storageOb.description,
    );
  }

  Map<String, dynamic> toJson() =>
      {"Description": description, "Ref_Key": refKey};

  static const empty = Storage(refKey: '', description: '');
  @override
  List<Object?> get props => [refKey, description];
}

