import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageFormater {
  Uint8List base64ToBites(String base64String) {
    return const Base64Decoder()
        .convert(base64String.replaceAll(RegExp(r'\s+'), ''));
  }

  Future<Uint8List> compressBites(Uint8List bites) async {
    var result = await FlutterImageCompress.compressWithList(bites,
        minHeight: 500, minWidth: 500, quality: 20, format: CompressFormat.png);
    return result;
  }





}
