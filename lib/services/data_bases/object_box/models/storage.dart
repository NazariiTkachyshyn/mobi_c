import 'package:mobi_c/services/data_sync_service/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Storage {
  @Id()
  int id;
   String refKey;
   String description;

  Storage({required this.refKey, required this.description, this.id = 0});

  factory Storage.fromApi(SyncStorage storage) => Storage(
      refKey: storage.refKey,
      description: storage.description);
}
