import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObStorage {
  @Id()
  int id;
  final String refKey;
  final String description;

  ObStorage({required this.refKey, required this.description, this.id = 0});

  factory ObStorage.fromApi(ApiStorage storage) => ObStorage(
      refKey: storage.refKey,
      description: storage.description);
}
