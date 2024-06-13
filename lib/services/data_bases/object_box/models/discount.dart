import 'package:mobi_c/services/data_sync_service/models/models.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Discount {
  @Id()
  int id;
   String discountRecipientKey;
   double percentDiscounts;

  Discount(
      {required this.discountRecipientKey,
      required this.percentDiscounts,
      this.id = 0});

  factory Discount.fromApi(SyncDiscount discount) => Discount(
      discountRecipientKey: discount.discountRecipientKey,
      percentDiscounts: discount.percentDiscounts);

  static final empty = Discount(discountRecipientKey: '', percentDiscounts: 0);
}
