import 'package:objectbox/objectbox.dart';

@Entity()
class Order {
  @Id()
  int id;
   DateTime? date;
   DateTime? shipmentDate;
   String counterpartyKey;
   String partnerKey;
   String storageKey;
   String organization;
   String contractKey;
   String comment;

  Order(
      {required this.date,
      required this.shipmentDate,
      required this.counterpartyKey,
      required this.partnerKey,
      required this.storageKey,
      required this.organization,
      required this.contractKey,
      required this.comment,
      this.id = 0});
}
