import 'package:mobi_c/services/data_sync_service/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Discount {
  @Id()
  int id;
   String discountRecipientKey;
   double percentDiscounts;
   String lineNumber;

  Discount(
      {required this.discountRecipientKey,
      required this.percentDiscounts,
      required this.lineNumber,
      this.id = 0});

  factory Discount.fromApi(SyncDiscount discount) => Discount(
      discountRecipientKey: discount.discountRecipientKey,
      percentDiscounts: discount.percentDiscounts,
      lineNumber: discount.lineNumber
      );

  static final empty = Discount(discountRecipientKey: '', percentDiscounts: 0, lineNumber: '0');
}
