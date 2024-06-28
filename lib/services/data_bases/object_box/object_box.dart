import 'package:mobi_c/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
        directory: p.join(docsDir.path, "obx3"),
        macosApplicationGroup: 'FGDTDLOBXDJ.demo');
    return ObjectBox._create(store);
  }
}
