import 'package:intl/intl.dart';

class KeyConst {
  static const priceType = '940e4d76-9712-11e4-249e-8e887ee7bcbd';
  static const storageKey = '3f3a05d9-2faf-11e1-b60b-3e32ff0a5e79';
  static const organizationKey = "49b22f0e-2258-11e1-b864-002354e1ef1c";
  static const unitKey = "9996c7ae-3f3e-11e9-9991-be1f4c7a0d70";
  static const currencyKey = '7fc302bf-2248-11e1-b864-002354e1ef1c';
}

List<Map> storages = [
  {'ref': '3f3a05d9-2faf-11e1-b60b-3e32ff0a5e79', 'name': 'Склад Львів'},
  {'ref': '3f3a05dd-2faf-11e1-b60b-3e32ff0a5e79', 'name': 'Склад Харків'},
  {'ref': '3f3a05da-2faf-11e1-b60b-3e32ff0a5e79', 'name': 'Склад Київ'}
];

  final numberFormat = NumberFormat('#,##0.00'); 
