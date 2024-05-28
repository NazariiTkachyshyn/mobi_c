import 'package:equatable/equatable.dart';

import '../services/data_bases/object_box/models/models.dart';

class Storage extends Equatable {
  final String refKey;
  final String description;

  const Storage({required this.refKey, required this.description});

  factory Storage.fromJson(Map<String, dynamic> json) => Storage(
      refKey: json['Ref_Key'] ?? '', description: json['Description'] ?? '');

  factory Storage.fromObStorage(ObStorage storage) => Storage(
        refKey: storage.refKey ?? '',
        description: storage.description ?? '',
      );
static const empty = Storage(refKey: '', description: '');
  @override
  List<Object?> get props => [refKey, description];
}
