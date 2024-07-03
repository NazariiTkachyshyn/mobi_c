import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/data_base/object_box/models/counterparty.dart';

class SyncCounterparty extends Equatable {
  final String refKey;
  final String description;
  final String mainCounterpartyKey;
  final String partnerKey;
  final String fullDescription;
  final String parentKey;
  final bool isFolder;

  const SyncCounterparty(
      {required this.refKey,
      required this.description,
      required this.partnerKey,
      required this.mainCounterpartyKey,
      required this.fullDescription,
      required this.parentKey,
      required this.isFolder
      });

  factory SyncCounterparty.fromJson(Map<String, dynamic> json) =>
      SyncCounterparty(
          refKey: json['Ref_Key'] ?? '',
          mainCounterpartyKey: json['ГоловнойКонтрагент_Key'] ?? '',
          partnerKey: json['Партнер_Key'] ?? '',
          description: json['Description'] ?? '',
          fullDescription: json['НаименованиеПолное'] ?? '',
          parentKey: json['Parent_Key'] ?? '',
          isFolder: json['IsFolder'] ?? false
          );

  factory SyncCounterparty.fromOb(Counterparty counterparty) => SyncCounterparty(
      refKey: counterparty.refKey,
      description: counterparty.description,
      mainCounterpartyKey: counterparty.mainCounterpartyKey,
      partnerKey: counterparty.partnerKey,
      fullDescription: counterparty.fullDescription,
      parentKey: counterparty.partnerKey,
      isFolder: counterparty.isFolder
      );



  static const empty = SyncCounterparty(
      refKey: '',
      description: '',
      mainCounterpartyKey: '',
      partnerKey: '',
      fullDescription: '',
      parentKey: '',
      isFolder: false
      );

  @override
  List<Object?> get props =>
      [refKey, description, mainCounterpartyKey, fullDescription, partnerKey, parentKey, isFolder];
}
