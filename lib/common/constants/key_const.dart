import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import 'package:mobi_c/common/models/config.dart';

final keysJson = GlobalConfiguration().getValue('keys');
final keysConfig = Keys.fromJson(keysJson);

class Key1Const {
  static final priceType = keysConfig.priceType;
  static const storageKey = '3f3a05d9-2faf-11e1-b60b-3e32ff0a5e79';
  static final organizationKey = keysConfig.organizationKey;
  static final unitKey = keysConfig.unitKey;
  static final currencyKey = keysConfig.currencyKey;
}

// List<Map> storages = [
//   {'ref': '3f3a05d9-2faf-11e1-b60b-3e32ff0a5e79', 'name': 'Склад Львів'},
//   {'ref': '3f3a05dd-2faf-11e1-b60b-3e32ff0a5e79', 'name': 'Склад Харків'},
//   {'ref': '3f3a05da-2faf-11e1-b60b-3e32ff0a5e79', 'name': 'Склад Київ'}
// ];

final numberFormat = NumberFormat('#,##0.00');
