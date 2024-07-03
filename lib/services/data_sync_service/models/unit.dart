import 'package:equatable/equatable.dart';
import 'package:mobi_c/services/data_base/object_box/models/unit.dart';

class SyncUnit extends Equatable {
  final String refKey;
  final String owner;
  final int ratio;
  final String classifierKey;
  final String description;

  const SyncUnit(
      {required this.refKey,
      required this.owner,
      required this.ratio,
      required this.classifierKey,
      required this.description});

  factory SyncUnit.fromJson(Map<String, dynamic> json) => SyncUnit(
      refKey: json['Ref_Key'] ?? '',
      owner: json['Owner'] ?? '',
      ratio: ((json['Коэффициент'] ?? 0) as num).toInt(),
      classifierKey: json['ЕдиницаПоКлассификатору_Key'] ?? '',
      description: json['Description'] ?? '');
      

  factory SyncUnit.fromOb(Unit unit) => SyncUnit(
      refKey: unit.refKey,
      owner: unit.owner,
      ratio: unit.ratio,
      classifierKey: unit.classifierKey,
      description: unit.description);

  static const empty = SyncUnit(
      refKey: '', owner: '', ratio: 0, classifierKey: '', description: '');
  @override
  List<Object?> get props => [refKey, owner, ratio, classifierKey, description];
}
