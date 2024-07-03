import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableComponent extends StatelessWidget {
  const SlidableComponent(
      {super.key,
      required this.child,
      required this.color,
      required this.icon,
      required this.lable,
      required this.onPressed});
  final Widget child;
  final Color color;
  final IconData icon;
  final String lable;
  final Function(BuildContext) onPressed;

  @override
  Widget build(BuildContext context) {
    ActionPane actionPane() {
      return ActionPane(motion: const DrawerMotion(), children: [
        SlidableAction(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          flex: 2,
          onPressed: onPressed,
          backgroundColor: color,
          foregroundColor: Colors.white,
          icon: icon,
          label: lable,
        )
      ]);
    }

    return Slidable(
        endActionPane: actionPane(),
        startActionPane: actionPane(),
        child: child);
  }
}
