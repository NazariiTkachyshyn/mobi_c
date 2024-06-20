import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobi_c/clients/odata_api_clients/odata_api_client.dart';
import 'package:mobi_c/feature/create_order/ui/create_order_page.dart';
import 'package:mobi_c/feature/home_page/ui/home_page.dart';
import 'package:mobi_c/feature/select_counterparty/ui/select_counterparty_page.dart';
import 'package:mobi_c/feature/select_nom/ui/select_nom_page.dart';
import 'package:mobi_c/feature/settings/cubit/settings_cubit.dart';
import 'package:mobi_c/feature/settings/ui/settings_page.dart';
import 'package:mobi_c/feature/settings/ui/pages/counterparty_page/counterparty_page.dart';
import 'package:mobi_c/feature/settings/ui/pages/views.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'services/data_bases/object_box/object_box.dart';

late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory docDir = await getApplicationDocumentsDirectory();

  objectbox = await ObjectBox.create();

  final store = objectbox.store;

  final odataApiClient = OdataApiClient();

  GetIt.instance.registerSingleton<Store>(store);
  GetIt.instance.registerSingleton<OdataApiClient>(odataApiClient);
  GetIt.instance.registerSingleton<Directory>(docDir);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('uk')],
        locale: const Locale('uk'),
        theme: AppTheme.light,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          'settings': (context) => const SettingsPage(),
          'sync': (context) => const SyncPage(),
          'settings_counterparty_view': (context) =>
              const SettingsCounterpartyPage(),
          'createOrderPage': (context) => const CreateOrderPage(),
          'selectCounterparty': (context) => const SelectCounterpartyPage(),
          'selectNom': (context) => const SelectNomPage()
        },
      ),
    );
  }
}
