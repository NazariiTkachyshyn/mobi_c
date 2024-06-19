
import 'package:flutter/material.dart';
import 'package:mobi_c/common/common.dart';

class ListTileImage extends StatelessWidget {
  const ListTileImage({super.key, required this.ref});
  final String ref;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
          maxWidth: 64,
          maxHeight: 64,
        ),
        child: Image.file(getImage(ref),
            errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.image_search_rounded,
            color: Colors.grey,
            size: 50,
          );
        }));
  }
}
