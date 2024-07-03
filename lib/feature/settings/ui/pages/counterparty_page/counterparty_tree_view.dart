// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/common/models/models.dart';
import 'package:mobi_c/feature/settings/cubit/settings_counterparty_cubit.dart';

class CounterpartyTreeView extends StatefulWidget {
  const CounterpartyTreeView({super.key});

  @override
  State<CounterpartyTreeView> createState() => _CounterpartyTreeViewState();
}

class _CounterpartyTreeViewState extends State<CounterpartyTreeView> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsCounterpartyCubit>().getFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            BlocBuilder<SettingsCounterpartyCubit, SettingsCounterpartyState>(
          builder: (context, state) {
            return ListView(
              children: state.counterpartyTree.map((item) {
                return CounterpartyNode(
                  node: item.copyWith(path: [item.description]),
                  routesIds: state.routes.map((e) => e.refKey).toList(),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
class CounterpartyNode extends StatelessWidget {
  final CounterpartyTree node;
  final List<String> routesIds;

  const CounterpartyNode({
    required this.node,
    required this.routesIds,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (node.children.isEmpty) {
      return LeafNode(node: node, routesIds: routesIds);
    } else {
      return ParentNode(node: node, routesIds: routesIds);
    }
  }
}

class LeafNode extends StatelessWidget {
  final CounterpartyTree node;
  final List<String> routesIds;

  const LeafNode({required this.node, required this.routesIds, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Padding(
        padding: EdgeInsets.only(left: 30),
        child: Icon(Icons.folder),
      ),
      title: Text(node.description),
      trailing: NodeCheckbox(
          node: node, initCheckboxValue: routesIds.contains(node.refKey)),
    );
  }
}

class ParentNode extends StatefulWidget {
  final CounterpartyTree node;
  final List<String> routesIds;

  const ParentNode({required this.node, required this.routesIds, super.key});

  @override
  _ParentNodeState createState() => _ParentNodeState();
}

class _ParentNodeState extends State<ParentNode>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
   
 
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const OutlineInputBorder(borderSide: BorderSide.none),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          RotationTransition(
            turns: _iconTurns,
            child: const Icon(Icons.expand_more),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 6),
            child: Icon(Icons.folder_copy),
          ),
        ],
      ),
      title: Text(widget.node.description),
      trailing: NodeCheckbox(
          node: widget.node,
          initCheckboxValue: widget.routesIds.contains(widget.node.refKey)),
      children: widget.node.children.map((child) {
        return Padding(
          padding: const EdgeInsets.only(left: 18),
          child: CounterpartyNode(
            node: child.copyWith(path: [...widget.node.path, child.description]),
            routesIds: widget.routesIds,
          ),
        );
      }).toList(),
      onExpansionChanged: (expanded) {
        setState(() {
          if (expanded) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        });
      },
    );
  }
}

class NodeCheckbox extends StatefulWidget {
  const NodeCheckbox(
      {required this.node, required this.initCheckboxValue, super.key});
  final CounterpartyTree node;
  final bool initCheckboxValue;

  @override
  State<NodeCheckbox> createState() => _NodeCheckboxState();
}

class _NodeCheckboxState extends State<NodeCheckbox> {
  bool? _checkBoxValue;

  @override
  void initState() {
    _checkBoxValue = widget.initCheckboxValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _checkBoxValue,
      onChanged: (isChecked) {
        setState(() {
          _checkBoxValue = isChecked;
        });
        if (_checkBoxValue ?? false) {
          context.read<SettingsCounterpartyCubit>().insertRoute(widget.node);
        } else {
          final state = context.read<SettingsCounterpartyCubit>().state;
          context.read<SettingsCounterpartyCubit>().deleteRoute(state.routes
              .firstWhere((e) => e.refKey == widget.node.refKey)
              .id);
        }
      },
    );
  }
}
