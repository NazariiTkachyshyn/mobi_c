import 'package:mobi_c/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObBarocde {
  @Id()
  int id;
  String? packKey;
  String? barcode;
  String? nomKey;

  ObBarocde(
      {required this.barcode,
      required this.packKey,
      required this.nomKey,
      this.id = 0});

  factory ObBarocde.fromApi(Barcode price) => ObBarocde(
      barcode: price.barcode, packKey: price.packKey, nomKey: price.nomKey);
}
