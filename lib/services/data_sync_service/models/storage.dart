import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/data_base/object_box/models/storage.dart';

class SyncStorage extends Equatable {
  final String refKey;
  final String description;

  const SyncStorage({required this.refKey, required this.description});

  factory SyncStorage.fromJson(Map<String, dynamic> json) => SyncStorage(
      refKey: json['Ref_Key'] ?? '', description: json['Description'] ?? '');

  factory SyncStorage.fromOb(Storage storage) => SyncStorage(
        refKey: storage.refKey,
        description: storage.description,
      );

  static const empty = SyncStorage(refKey: '', description: '');
  @override
  List<Object?> get props => [refKey, description];
}
