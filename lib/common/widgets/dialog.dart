import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

showCheckDialog(BuildContext context,
    {final String? cancelLable,
    final String? acceptLable,
    final String? title,
    final String? description,
    final Function? onPressedCancel,
    final Function? onPressedAccept}) {
  showModal(
    context: context,
    builder: (context) => CheckDialog(
      cancelLable: cancelLable,
      acceptLable: acceptLable,
      title: title,
      description: description,
      onPressedAccept: onPressedAccept ?? () {},
      onPressedCancel: onPressedCancel ?? () {},
    ),
  );
}

class CheckDialog extends StatelessWidget {
  const CheckDialog(
      {super.key,
      this.cancelLable,
      this.acceptLable,
      this.title,
      this.description,
      required this.onPressedCancel,
      required this.onPressedAccept});

  final String? cancelLable;
  final String? acceptLable;
  final String? title;
  final String? description;
  final Function onPressedCancel;
  final Function onPressedAccept;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? ''),
      content: Text(description ?? ''),
      actions: [
        TextButton(
            onPressed: () {
              onPressedCancel();
              Navigator.pop(context);
            },
            child: Text(cancelLable ?? 'Ні')),
        TextButton(
            onPressed: () {
              onPressedAccept();
              Navigator.pop(context);
            },
            child: Text(acceptLable ?? 'Так'))
      ],
    );
  }
}
