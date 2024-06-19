import 'dart:io';

import 'package:get_it/get_it.dart';

double calcDiscount(double price, double discount) {
  return price * (1 - discount / 100);
}

File getImage(String filename) {
  final docDir = GetIt.I.get<Directory>();
  File file = File('${docDir.path}/$filename.jpg');
  return file;
}
