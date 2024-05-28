import 'package:objectbox/objectbox.dart';

import '../../../../models/models.dart';

@Entity()
class ObStorage {
  @Id()
  int id;
  String? refKey;
  String? description;

  ObStorage({required this.refKey, required this.description, this.id = 0});

  factory ObStorage.fromApi(Storage storage) =>
      ObStorage(refKey: storage.refKey, description: storage.description);
}
