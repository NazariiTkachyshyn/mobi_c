import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Storage {
  @Id()
  int id;
  final String refKey;
  final String description;

  Storage({required this.refKey, required this.description, this.id = 0});

  factory Storage.fromApi(ApiStorage storage) => Storage(
      refKey: storage.refKey,
      description: storage.description);
}
