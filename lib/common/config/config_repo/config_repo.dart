import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mobi_c/common/models/config.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/config.dart';

class ConfigRepo {
  final _store = GetIt.I.get<Store>();

  Future<Config> getConfig() async {
    final config = await FirebaseFirestore.instance.collection('config').get();
    final configData = config.docs;
    return Config.fromJson(configData.first.data());
  }

  Future<Config> getConfigFromOb() async {
    final dbConnOb = (await _store.box<DbConnOb>().getAllAsync()).last;
    final imagesDbOb = (await _store.box<ImagesDbOb>().getAllAsync()).last;
    final keysOb = (await _store.box<KeysOb>().getAllAsync()).last;
    final storagesOb = await _store.box<StorageOb>().getAllAsync();

    return Config(
        storages: storagesOb
            .map((e) => ConfigStorage(refKey: e.refKey, description: e.description))
            .toList(),
        dbConn: DbConn(
            path: dbConnOb.path,
            pass: dbConnOb.pass,
            host: dbConnOb.host,
            user: dbConnOb.user),
        imagesDb: ImagesDb(port: imagesDbOb.port, host: imagesDbOb.host),
        keys: Keys(
            unitKey: keysOb.unitKey,
            priceType: keysOb.priceType,
            currencyKey: keysOb.currencyKey,
            organizationKey: keysOb.organizationKey));
  }

  writeConfig()async{
     final config = await FirebaseFirestore.instance.collection('config').get();
    final configData = config.docs;
      GlobalConfiguration().loadFromMap(configData.first.data());
      print( GlobalConfiguration().get('dbConn'));

  }

}
