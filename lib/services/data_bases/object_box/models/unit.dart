import 'package:mobi_c/models/models.dart';
import 'package:mobi_c/models/unit.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Unit {
  @Id()
  int id;
  final String refKey;
  final String owner;
  final int ratio;
  final String classifierKey;
  final String description;

  Unit(
      {required this.refKey,
      required this.owner,
      required this.ratio,
      required this.classifierKey,
      required this.description,
      this.id = 0});

  factory Unit.fromApi(ApiUnit unit) => Unit(
      refKey: unit.refKey,
      owner: unit.owner,
      ratio: unit.ratio,
      classifierKey: unit.classifierKey,
      description: unit.description);
}

@Entity()
class UnitClassifier {
   int id;
  final String refKey;
  final String description;
  final String fullDescription;

   UnitClassifier(
      {this.id = 0,
      required this.refKey,
      required this.description,
      required this.fullDescription});

  factory UnitClassifier.fromApi(ApiUnitClassifier unitClassifiers) =>
      UnitClassifier(
          refKey: unitClassifiers.refKey,
          description: unitClassifiers.description,
          fullDescription: unitClassifiers.fullDescription);
}
