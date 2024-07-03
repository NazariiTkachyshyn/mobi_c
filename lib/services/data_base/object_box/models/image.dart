import 'package:objectbox/objectbox.dart';

@Entity()
class ImageOb {
  @Id()
  int id;
  String ref;
  String imageBase64;

  ImageOb({required this.ref, required this.imageBase64, this.id = 0});
}
