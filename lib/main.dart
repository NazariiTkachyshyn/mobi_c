import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mobi_c/feature/create_order/ui/create_order_page.dart';
import 'package:mobi_c/feature/select_counterparty/ui/select_counterparty_page.dart';
import 'package:mobi_c/feature/select_nom/ui/select_nom_page.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import 'package:mobi_c/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';

import 'services/data_bases/object_box/object_box.dart';

typedef DocDir = Directory;
typedef ImageDir = Directory;

late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DocDir docDir = await getApplicationDocumentsDirectory();
  final ImageDir imageDir = ImageDir("${docDir.path}/images");

  objectbox = await ObjectBox.create();

  final store = objectbox.store;

  // store.box<Nom>().query().build().remove();
  // store.box<Counterparty>().query().build().remove();
  // store.box<Contract>().removeAll();
  // store.box<Discount>().query().build().remove();
  store.box<ImageOb>().query().build().remove();

  GetIt.instance.registerSingleton<Store>(store);
  GetIt.instance.registerSingleton<DocDir>(docDir);
  GetIt.instance.registerSingleton<ImageDir>(imageDir);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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

// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:http/http.dart' as http;
// import 'package:mobi_c/common/constants/api_constants.dart';
// late ObjectBox objectbox;

// void main() async{
//     WidgetsFlutterBinding.ensureInitialized();
//   objectbox = await ObjectBox.create();

//   final store = objectbox.store;
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('HTTP Request Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<List<Uint8List>>(
//             future: fetchImageData(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) =>
//                       Image.memory(snapshot.data![index]),
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               }
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Future<List<Uint8List>> fetchImageData() async {
//     final headers = {
//       'Authorization': ApiConstants.basicAuth,
//       "Accept": "application/json",
//       "Accept-Charset": "UTF-8",
//       "Content-Type": "application/json",
//     };

//     final String apiUrl =
//         'http://192.168.2.50:81/virok_test/odata/standard.odata/Catalog_ХранилищеДополнительнойИнформации?\$format=json&\$top=100&\$select=Хранилище_Base64Data';

//     final response = await http.get(Uri.parse(apiUrl), headers: headers);
//     final jsonResponse = jsonDecode(response.body);
//     final List<dynamic> dataList = jsonResponse['value'];

//     List<Uint8List> imageList = [];
//     for (var data in dataList) {
//       final base64String =
//           data['Хранилище_Base64Data'].replaceAll(RegExp(r'\s+'), '');
//       final decodedData = Base64Decoder().convert(base64String);
//       final compressedData = await testComporessList(decodedData);
//       imageList.add(compressedData);
//     }

//     return imageList;
//   }
// }

// Future<Uint8List> testComporessList(Uint8List list) async {
//   var result = await FlutterImageCompress.compressWithList(list,
//       minHeight: 500, minWidth: 500, quality: 20);
//   // print(list.length);
//   // print(result.length);
//   print(base64Encode(result).length);
//   return result;
// }
