import 'package:equatable/equatable.dart';

class Unit extends Equatable {
  final String refKey;
  final String owner;
  final int ratio;
  final String clasificatorKey;
  final String description;

  const Unit(
      {required this.refKey,
      required this.owner,
      required this.ratio,
      required this.clasificatorKey,
      required this.description});

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
      refKey: json['Ref_Key'] ?? '',
      owner: json['Owner'] ?? '',
      ratio: ((json['Коэффициент'] ?? 0) as num).toInt(),
      clasificatorKey: json['ЕдиницаПоКлассификатору_Key'] ?? '',
      description: json['Description'] ?? '');

  Map<String, dynamic> toJson() {
    return {
      'Ref_Key': refKey,
      'Owner': owner,
      "Коэффициент": ratio,
      "ЕдиницаПоКлассификатору_Key": clasificatorKey
    };
  }

  static const empty = Unit(
      refKey: '', owner: '', ratio: 0, clasificatorKey: '', description: '');
  @override
  List<Object?> get props =>
      [refKey, owner, ratio, clasificatorKey, description];
}

class UnitClassificator extends Equatable {
  final String refKey;
  final String description;
  final String fullDescription;

  factory UnitClassificator.fromJson(Map<String, dynamic> json) =>
      UnitClassificator(
        refKey: json['Ref_Key'] ?? '',
        description: json['Description'] ?? '',
        fullDescription: json['НаименованиеПолное'] ?? '',
      );

  const UnitClassificator(
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
      UnitClassificator(refKey: '', description: '', fullDescription: '');
  @override
  List<Object?> get props => [refKey, description, fullDescription];
}
