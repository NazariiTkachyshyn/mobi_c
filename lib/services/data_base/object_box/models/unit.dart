import 'package:mobi_c/services/data_sync_service/models/models.dart';
import 'package:mobi_c/services/data_sync_service/models/unit.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Unit {
  @Id()
  int id;
  String refKey;
  String owner;
  int ratio;
  String classifierKey;
  String description;

  Unit(
      {required this.refKey,
      required this.owner,
      required this.ratio,
      required this.classifierKey,
      required this.description,
      this.id = 0});

  factory Unit.fromApi(SyncUnit unit) => Unit(
      refKey: unit.refKey,
      owner: unit.owner,
      ratio: unit.ratio,
      classifierKey: unit.classifierKey,
      description: unit.description);

  static final empty =
      Unit(refKey: '', owner: '', ratio: 1, classifierKey: '', description: '');
}

