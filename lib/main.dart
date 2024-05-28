import 'package:mobi_c/feature/create_order/ui/create_order_page.dart';
import 'package:mobi_c/feature/select_counterparty/ui/select_counterparty_page.dart';
import 'package:mobi_c/feature/select_nom/ui/select_nom_page.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/sqlite/sqlite.dart';
import 'package:mobi_c/services/data_sync_service/data_sync_service.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import 'package:mobi_c/services/data_bases/object_box/models/ob.price.dart';
import 'package:mobi_c/services/data_bases/object_box/models/ob_counterparty.dart';
import 'package:mobi_c/services/data_bases/object_box/models/ob_nom.dart';
import 'package:mobi_c/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

import 'services/data_bases/object_box/object_box.dart';

late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();

  final store = objectbox.store;
  final sqlite = await SQFLiteServices().database;

await sqlite.delete('noms');
// await sqlite.delete('prices');
  GetIt.instance.registerSingleton<Store>(store);
  GetIt.instance.registerSingleton<Database>(sqlite);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    // objectbox.store.box<ObNom>().removeAll();
    // objectbox.store.box<ObPrice>().removeAll();
    // objectbox.store.box<ObBarocde>().removeAll();
    // objectbox.store.box<ObStorage>().removeAll();
    // objectbox.store.box<ObCounterparty>().removeAll();
    // DataSyncService().syncBarcodesData();
    DataSyncService().syncNomData();
    DataSyncService().syncPriceData();
    // DataSyncService().syncStoragesData();
    DataSyncService().syncCounterpartyData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('uk')],
      locale: const Locale('uk'),
      theme: AppTheme.light,
      initialRoute: 'createOrderPage',
      routes: {
        'createOrderPage': (context) => const CreateOrderPage(),
        'selectCounterparty': (context) => const SelectCounterpartyPage(),
        'selectNom': (context) => const SelectNomPage()
      },
    );
  }
}
