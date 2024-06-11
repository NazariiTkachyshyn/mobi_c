import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObUnit {
  @Id()
  int id;
  final String refKey;
  final String owner;
  final int ratio;
  final String classifierKey;
  final String description;

  ObUnit(
      {required this.refKey,
        required this.owner,
        required this.ratio,
        required this.classifierKey,
        required this.description,
        this.id = 0});

  factory ObUnit.fromApi(ApiUnit unit) => ObUnit(
      refKey: unit.refKey,
      owner: unit.owner,
      ratio: unit.ratio,
      classifierKey: unit.classifierKey,
      description: unit.description);
}
