import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_sync_service/models/full_order.dart';

class OrderRepository {
  final Box<FullOrder> orderBox;

  OrderRepository(this.orderBox);

  Future<void> saveOrderOffline(FullOrder order) async {
    orderBox.put(order);
  }
}
