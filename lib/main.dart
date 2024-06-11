import 'package:get_it/get_it.dart';
import 'package:mobi_c/feature/create_order/ui/create_order_page.dart';
import 'package:mobi_c/feature/select_counterparty/ui/select_counterparty_page.dart';
import 'package:mobi_c/feature/select_nom/ui/select_nom_page.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'services/data_bases/object_box/object_box.dart';
// late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final objectbox = await ObjectBox.create();

  final store = objectbox.store;

  GetIt.instance.registerSingleton<Store>(store);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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
