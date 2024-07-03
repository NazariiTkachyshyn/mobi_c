
import 'package:intl/intl.dart';

//   final _prefs = GetIt.I.get<SharedPreferences>();


// final strConfig = _prefs.getString ('config') ?? '';
// final jsonconfig = jsonDecode(strConfig);
// final config = ConfigModel.fromJson(jsonconfig);



// class KeyConst {
//   static final priceType = config.keys.priceType;
//   static final storageKey = config.userStorage;
//   static final organizationKey = config.keys.organizationKey;
//   static final unitKey = config.keys.unitKey;
//   static final currencyKey = config.keys.currencyKey;
//   static final storages = config.storages;
// }

final numberFormat = NumberFormat('#,##0.00');



List<Map> storages = [
  {'ref': '3f3a05d9-2faf-11e1-b60b-3e32ff0a5e79', 'name': 'Склад Львів'},
  {'ref': '3f3a05dd-2faf-11e1-b60b-3e32ff0a5e79', 'name': 'Склад Харків'},
  {'ref': '3f3a05da-2faf-11e1-b60b-3e32ff0a5e79', 'name': 'Склад Київ'}
];