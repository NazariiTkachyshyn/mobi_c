import 'package:objectbox/objectbox.dart';

@Entity()
class Order {
  @Id()
  int id;
  final DateTime? date;
  final DateTime? shipmentDate;
  final String counterpartyKey;
  final String partnerKey;
  final String storageKey;
  final String organization;
  final String contractKey;
  final String comment;

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
