import 'package:objectbox/objectbox.dart';

@Entity()
class ClientRoute {
  @Id()
  int id;
  String refKey;
  String description;

  ClientRoute(
      {required this.refKey,
      required this.description,
      this.id = 0});
}
