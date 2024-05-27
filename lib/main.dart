// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mobi_c/objectbox.g.dart';
// import 'package:mobi_c/services/object_box/models/ob_nom.dart';
// import 'package:mobi_c/services/object_box/object_box.dart';

// class IbNom {
//   int id;
//   String? ref;
//   String? description;
//   String? descriptionLower;
//   String? article;
//   String? articleLower;
//   String? parentKey;
//   String? imageKey;
//   String? unitKey;
//   List<IbNom> children = [];

//   IbNom(
//       {required this.id,
//       required this.ref,
//       required this.article,
//       required this.articleLower,
//       required this.description,
//       required this.descriptionLower,
//       required this.parentKey,
//       required this.unitKey});
//   factory IbNom.fromApi(ObNom nom) => IbNom(
//       id: nom.id,
//       ref: nom.ref,
//       article: nom.article,
//       articleLower: nom.article,
//       descriptionLower: nom.description,
//       description: nom.description,
//       parentKey: nom.parentKey,
//       unitKey: nom.unitKey);

//   void addChild(IbNom child) {
//     children.add(child);
//   }
// }

// // Function to build the tree
// List<IbNom> buildTree(List<IbNom> ibNoms) {
//   final Map<String, IbNom> map = {};
//   final List<IbNom> roots = [];

//   // Create a map of id to IbNom
//   for (var ibNom in ibNoms) {
//     map[ibNom.ref!] = ibNom;
//   }

//   // Build the tree
//   for (var ibNom in ibNoms) {
//     if (ibNom.parentKey == '00000000-0000-0000-0000-000000000000') {
//       roots.add(ibNom);
//     } else {
//       map[ibNom.parentKey!]?.addChild(ibNom);
//     }
//   }

//   return roots;
// }

// class TreeWidget extends StatelessWidget {
//   final List<IbNom> treeData;

//   TreeWidget({required this.treeData});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: treeData.map((item) => buildNode(item)).toList(),
//     );
//   }

//   Widget buildNode(IbNom node) {
//     if (node.children.isEmpty) {
//       return ListTile(
//         title: Text(node.description ?? ''),
//       );
//     } else {
//       return ExpansionTile(
//         title: Text(node.description ?? ''),
//         children: node.children.map((child) => buildNode(child)).toList(),
//       );
//     }
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final objectbox = await ObjectBox.create();

//   final store = objectbox.store;

//   GetIt.instance.registerSingleton<Store>(store);
//   List<IbNom> ibNoms =
//       store.box<ObNom>().getAll().map((e) => IbNom.fromApi(e)).toList();
//   List<IbNom> treeData = buildTree(ibNoms);

//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(title: Text('Dynamic Tree')),
//       body: TreeWidget(treeData: treeData),
//     ),
//   ));
// }

import 'package:mobi_c/feature/create_order/ui/create_order_page.dart';
import 'package:mobi_c/feature/select_counterparty/ui/select_counterparty_page.dart';
import 'package:mobi_c/feature/select_nom/ui/select_nom_page.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_sync_service/data_sync_service.dart';
import 'package:mobi_c/services/object_box/models/models.dart';
import 'package:mobi_c/services/object_box/models/ob.price.dart';
import 'package:mobi_c/services/object_box/models/ob_counterparty.dart';
import 'package:mobi_c/services/object_box/models/ob_nom.dart';
import 'package:mobi_c/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

import 'services/object_box/object_box.dart';

late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();

  final store = objectbox.store;

  GetIt.instance.registerSingleton<Store>(store);

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
    // DataSyncService().syncNomData();
    // DataSyncService().syncPriceData();
    // DataSyncService().syncStoragesData();
    // DataSyncService().syncCounterpartyData();
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
