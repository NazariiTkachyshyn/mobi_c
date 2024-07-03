import 'package:mobi_c/services/data_sync_service/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Barcode {
  @Id()
  int id;
   String barcode;
   String nomKey;
   String packKey;

  Barcode(
      {required this.barcode,
        required this.nomKey,
        required this.packKey,
        this.id = 0});

  factory Barcode.fromApi(SyncBarcode barcode) => Barcode(
      barcode: barcode.barcode,
      nomKey: barcode.nomKey,
      packKey: barcode.packKey);
}
