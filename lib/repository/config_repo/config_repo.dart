import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:mobi_c/common/models/config.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/repository/authentication_repository/models/user.dart';
import 'package:mobi_c/services/data_base/object_box/models/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigRepo {
  final _store = GetIt.I.get<Store>();
  final _prefs = GetIt.I.get<SharedPreferences>();

  writeConfig(User user) async {
    final config = await FirebaseFirestore.instance.collection('config').get();
    final configData = config.docs.first.data();
    configData.addAll({'userStorage': user.storage.refKey, 'odata_responsible_ref':user.responsibleUser});

    await _prefs.setString('config', jsonEncode(configData));
    final routes = user.routes
        .map((e) => ClientRoute(refKey: e.ref, description: e.description))
        .toList();

    await _store.box<ClientRoute>().putManyAsync(routes);
  }

  cleanConfig() async {
    await _prefs.remove('config');
    await _store.box<ClientRoute>().removeAllAsync();
  }
}

class Config {
  static ConfigModel _loadConfig()  {
 final prefs = GetIt.I.get<SharedPreferences>();

final strConfig = prefs.getString('config') ?? '';
final jsonconfig = jsonDecode(strConfig);
return ConfigModel.fromJson(jsonconfig);
  }

  static String get priceType  {
    final config =  _loadConfig();
    return config.keys.priceType;
  }

  static String get storageKey  {
    final config =  _loadConfig();
    return config.userStorage;
  }
 static String get responsibleUser  {
    final config =  _loadConfig();
    return config.responsibleUser;
  }
  static String get organizationKey  {
    final config =  _loadConfig();
    return config.keys.organizationKey;
  }

  static String get unitKey  {
    final config =  _loadConfig();
    return config.keys.unitKey;
  }

  static String get currencyKey  {
    final config =  _loadConfig();
    return config.keys.currencyKey;
  }

  static List<ConfigStorage> get storages  {
    final config =  _loadConfig();
    return config.storages;
  }

  static String get odataHost  {
    final config =  _loadConfig();
    return config.dbConn.host;
  }

  static String get odataPath  {
    final config =  _loadConfig();
    return config.dbConn.path;
  }

  static String get odataUser  {
    final config =  _loadConfig();
    return config.dbConn.user;
  }

  static String get odataPass  {
    final config =  _loadConfig();
    return config.dbConn.pass;
  }
  static String get basicAuth  {
    final config =  _loadConfig();

    final odataUser = config.dbConn.user;
    final odataPass = config.dbConn.pass;
    return 'Basic ${base64Encode(utf8.encode('$odataUser:$odataPass'))}';
  }

  static String get imagesDbHost  {
    final config =  _loadConfig();
    return config.imagesDb.host;
  }

  static int get imagesDbPort  {
    final config =  _loadConfig();
    return config.imagesDb.port;
  }
}
