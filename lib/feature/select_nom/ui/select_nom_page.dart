import 'package:mobi_c/feature/select_nom/cubit/select_nom_cubit.dart';
import 'package:mobi_c/feature/select_nom/select_nom_client/select_nom_client.dart';
import 'package:mobi_c/feature/select_nom/select_nom_repo/select_nom_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/models/models.dart';

import '../../../common/common.dart';

class SelectNomPage extends StatefulWidget {
  const SelectNomPage({super.key});

  @override
  State<SelectNomPage> createState() => _SelectNomPageState();
}

class _SelectNomPageState extends State<SelectNomPage> {
  SearchType searchType = SearchType.folder;

  @override
  Widget build(context) {
    final onSelect =
        ModalRoute.of(context)!.settings.arguments as Function(Nom nom);
    return BlocProvider(
        create: (context) => SelectNomCubit(
            SelectNomRepoImpl(selectNomClient: SelectNomClient())),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Row(
              children: [
                Icon(Icons.production_quantity_limits),
                Text('Товари'),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    searchType = searchType.isFolder
                        ? SearchType.textField
                        : SearchType.folder;
                    setState(() {});
                  },
                  icon: Icon(searchType.isFolder
                      ? Icons.search
                      : Icons.folder_copy_outlined)),
            ],
          ),
          body: searchType.isFolder
              ? _SearchByFolder(
                  onSelect: onSelect,
                )
              : _SearchByTextField(
                  onSelect: onSelect,
                ),
        ));
  }
}

class _SearchByTextField extends StatefulWidget {
  const _SearchByTextField({required this.onSelect});
  final Function(Nom nom) onSelect;

  @override
  State<_SearchByTextField> createState() => _SearchByTextFieldState();
}

class _SearchByTextFieldState extends State<_SearchByTextField> {
  @override
  void initState() {
    context.read<SelectNomCubit>().getAllNoms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<SelectNomCubit, SelectNomState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              TextField(
                onChanged: (value) {
                  context.read<SelectNomCubit>().getNoms(value);
                },
                decoration:
                    const InputDecoration(labelText: 'Назва або артикул'),
              ),
              const Padding(padding: EdgeInsets.all(4)),
              Expanded(
                  child: ListView.builder(
                itemCount: state.noms.length,
                itemBuilder: (context, index) {
                  final nom = state.noms[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      onTap: () {
                        widget.onSelect(nom);
                      },
                      title: Text(nom.description),
                      subtitle: Text(nom.article),
                    ),
                  );
                },
              ))
            ],
          );
        },
      ),
    );
  }
}

class _SearchByFolder extends StatefulWidget {
  const _SearchByFolder({required this.onSelect});
  final Function(Nom nom) onSelect;

  @override
  State<_SearchByFolder> createState() => _SearchByFolderState();
}

class _SearchByFolderState extends State<_SearchByFolder> {
  @override
  void initState() {
    context.read<SelectNomCubit>().getAllNoms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<SelectNomCubit, SelectNomState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Nom> treeData = buildTree(state.noms);

          return TreeWidget(
            treeData: treeData,
            onSelect: widget.onSelect,
          );
        },
      ),
    );
  }
}

List<Nom> buildTree(List<Nom> noms) {
  final Map<String, Nom> map = {};
  final List<Nom> roots = [];

  for (var nom in noms) {
    map[nom.ref] = nom;
  }

  for (var nom in noms) {
    if (nom.parentKey == '00000000-0000-0000-0000-000000000000' &&
        nom.isFolder) {
      roots.add(nom);
    } else {
      map[nom.parentKey]?.addChild(nom);
    }
  }

  return roots;
}

class TreeWidget extends StatelessWidget {
  final List<Nom> treeData;
  final Function(Nom nom) onSelect;

  const TreeWidget({super.key, required this.treeData, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: treeData.map((item) => buildNode(item, context)).toList(),
    );
  }

  Widget buildNode(Nom node, BuildContext context) {
    if (node.children.isEmpty && node.isFolder == false) {
      return ListTile(
        title: Text(node.description),
        onTap: () {
          onSelect(node);
        },
      );
    } else {
      return ExpansionTile(
        title: Text(node.description),
        children:
            node.children.map((child) => buildNode(child, context)).toList(),
      );
    }
  }
}
