import 'package:equatable/equatable.dart';

class ApiUnit extends Equatable {
  final String refKey;
  final String owner;
  final int ratio;
  final String classifierKey;
  final String description;

  const ApiUnit(
      {required this.refKey,
      required this.owner,
      required this.ratio,
      required this.classifierKey,
      required this.description});

  factory ApiUnit.fromJson(Map<String, dynamic> json) => ApiUnit(
      refKey: json['Ref_Key'] ?? '',
      owner: json['Owner'] ?? '',
      ratio: ((json['Коэффициент'] ?? 0) as num).toInt(),
      classifierKey: json['ЕдиницаПоКлассификатору_Key'] ?? '',
      description: json['Description'] ?? '');

  Map<String, dynamic> toJson() {
    return {
      'Ref_Key': refKey,
      'Owner': owner,
      "Коэффициент": ratio,
      "ЕдиницаПоКлассификатору_Key": classifierKey
    };
  }

  static const empty = ApiUnit(
      refKey: '', owner: '', ratio: 0, classifierKey: '', description: '');
  @override
  List<Object?> get props =>
      [refKey, owner, ratio, classifierKey, description];
}

class UnitClassifier extends Equatable {
  final String refKey;
  final String description;
  final String fullDescription;

  factory UnitClassifier.fromJson(Map<String, dynamic> json) =>
      UnitClassifier(
        refKey: json['Ref_Key'] ?? '',
        description: json['Description'] ?? '',
        fullDescription: json['НаименованиеПолное'] ?? '',
      );

  const UnitClassifier(
      {required this.refKey,
      required this.description,
      required this.fullDescription});

  Map<String, dynamic> toJson() {
    return {
      'Ref_Key': refKey,
      'Description': description,
      "НаименованиеПолное": fullDescription
    };
  }

  static const empty =
      UnitClassifier(refKey: '', description: '', fullDescription: '');
  @override
  List<Object?> get props => [refKey, description, fullDescription];
}
