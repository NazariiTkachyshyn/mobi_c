import 'package:flutter/material.dart';

class TextFielButton extends StatelessWidget {
  const TextFielButton(
      {super.key, required this.text, this.onTap, required this.lableText, this.prefixIcon});

  final String text;
  final String lableText;
  final Widget? prefixIcon;

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.text = text;
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: TextField(
        enabled: false,
        controller: controller,
        style: theme.textTheme.titleMedium!
            .copyWith(fontWeight: FontWeight.w400, color: Colors.black87),
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.black54)),
            labelText: lableText,
            labelStyle: TextStyle(color: Colors.black54),
            suffixIcon: const Icon(Icons.arrow_drop_down_sharp)),
      ),
    );
  }
}
