import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobi_c/main.dart';

class ListTileImage extends StatelessWidget {
  const ListTileImage({super.key, required this.ref});
  final String ref;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 50,width: 50,);
  //   File getImage(String filename) {
  //     final imageDir = GetIt.I.get<ImageDir>();
  //     File file = File('${imageDir.path}/$filename');
  //     return file;
  //   }

  //   return ConstrainedBox(
  //       constraints: const BoxConstraints(
  //         minWidth: 44,
  //         minHeight: 44,
  //         maxWidth: 64,
  //         maxHeight: 64,
  //       ),
  //       child: Image.file(
  //         getImage(ref),
  //         errorBuilder: (context, error, stackTrace) => const Icon(
  //           Icons.image_search_rounded,
  //           color: Colors.grey,
  //           size: 50,
  //         ),
  //       ));
   }
}
