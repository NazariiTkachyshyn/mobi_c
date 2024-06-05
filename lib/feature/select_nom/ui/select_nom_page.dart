import 'package:mobi_c/common/func.dart';
import 'package:mobi_c/feature/select_nom/cubit/select_nom_cubit.dart';
import 'package:mobi_c/feature/select_nom/select_nom_client/select_nom_client.dart';
import 'package:mobi_c/feature/select_nom/select_nom_repo/select_nom_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/models/models.dart';

import '../../../common/common.dart';

String parentKey = '';

class SelectNomPage extends StatefulWidget {
  const SelectNomPage({super.key});

  @override
  State<SelectNomPage> createState() => _SelectNomPageState();
}

class _SelectNomPageState extends State<SelectNomPage> {
  @override
  Widget build(context) {
    return BlocProvider(
        create: (context) => SelectNomCubit(
            SelectNomRepoImpl(selectNomClient: SelectNomClient())),
        child: const SelectNomView());
  }
}

class SelectNomView extends StatefulWidget {
  const SelectNomView({super.key});

  @override
  State<SelectNomView> createState() => _SelectNomViewState();
}

class _SelectNomViewState extends State<SelectNomView> {
  SearchType searchType = SearchType.folder;
  @override
  void initState() {
    context.read<SelectNomCubit>().getFolders();
    super.initState();
  }

  @override
  Widget build(context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final onSelect = arguments['onTap'] as Function(Nom nom);
    final discount = arguments['discount'];
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (searchType.isFolder) {
                  Navigator.pop(context);
                }
                context.read<SelectNomCubit>().getFolders();

                searchType = SearchType.folder;
                setState(() {});
              },
              icon: const Icon(Icons.arrow_back)),
          centerTitle: false,
          title: const Row(
            children: [
              Icon(Icons.production_quantity_limits),
              Text('Товари'),
            ],
          ),
        ),
        body: searchType.isFolder
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocConsumer<SelectNomCubit, SelectNomState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    List<TreeNom> treeData = buildTree(state.folders
                        .map((e) => TreeNom.toTreeNom(e))
                        .toList());

                    return ListView(
                      children: treeData
                          .map((item) => buildNode(item, context))
                          .toList(),
                    );
                  },
                ),
              )
            : _SearchByTextField(
                onSelect: onSelect,
                parentKey: parentKey,
                discount: discount,
              ));
  }

  Widget buildNode(TreeNom node, BuildContext context) {
    if (node.children.isEmpty) {
      return ListTile(
        title: Text(node.description),
        onTap: () {
          print(node.ref);
          if (node.ref.isEmpty) {
            context.read<SelectNomCubit>().getAllNoms();
          }

          parentKey = node.ref;
          searchType =
              searchType.isFolder ? SearchType.textField : SearchType.folder;

          setState(() {});
        },
      );
    } else {
      return ExpansionTile(
        onExpansionChanged: (value) {},
        title: Text(node.description),
        children:
            node.children.map((child) => buildNode(child, context)).toList(),
      );
    }
  }
}

class _SearchByTextField extends StatefulWidget {
  const _SearchByTextField(
      {required this.onSelect,
      required this.parentKey,
      required this.discount});
  final Function(Nom nom) onSelect;
  final String parentKey;
  final double discount;

  @override
  State<_SearchByTextField> createState() => _SearchByTextFieldState();
}

class _SearchByTextFieldState extends State<_SearchByTextField> {
  @override
  void initState() {
    context.read<SelectNomCubit>().getNomsByParentKey(widget.parentKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<SelectNomCubit, SelectNomState>(
        listener: (context, state) {},
        builder: (context, state) {
          final noms = state.searchNoms;
          return Column(
            children: [
              TextField(
                onChanged: (value) {
                  context.read<SelectNomCubit>().getNomsInFolder(value);
                },
                decoration:
                    const InputDecoration(labelText: 'Назва або артикул'),
              ),
              const Padding(padding: EdgeInsets.all(4)),
              Expanded(
                  child: ListView.builder(
                itemCount: noms.length,
                itemBuilder: (context, index) {
                  final nom = noms[index];
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
                      trailing: Text(
                          nom.calcDiscount(widget.discount).toStringAsFixed(2)),
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

List<TreeNom> buildTree(List<TreeNom> noms) {
  final Map<String, TreeNom> map = {};
  final List<TreeNom> roots = [
    TreeNom(
        id: 0,
        ref: '',
        isFolder: true,
        description: 'Показати все',
        article: '',
        parentKey: '',
        unitKey: '',
        imageKey: '',
        children: [],
        price: 0)
  ];

  for (var nom in noms) {
    map[nom.ref] = nom;
  }

  for (var nom in noms) {
    if (nom.isFolder &&
        (nom.ref == 'd1a81622-d0a2-11e1-9a25-c24921fc8a30' ||
            nom.ref == '08f6f5d4-24c0-11e1-b235-3e32ff0a5e79' ||
            nom.ref == '35e3c75c-24bf-11e1-b235-3e32ff0a5e79')) {
      roots.add(nom);
    } else {
      map[nom.parentKey]?.addChild(nom);
    }
  }
  roots.add(TreeNom(
      id: 0,
      ref: '',
      isFolder: true,
      description: '',
      article: '',
      parentKey: '',
      unitKey: 'uniKey',
      imageKey: '',
      children: [],
      price: 0));

  return roots;
}

class TreeNom {
  final int id;
  final String ref;
  final bool isFolder;
  final String description;
  final String article;
  final String parentKey;
  final String unitKey;
  final String imageKey;
  final double price;
  List<TreeNom> children;

  TreeNom(
      {required this.id,
      required this.ref,
      required this.isFolder,
      required this.description,
      required this.article,
      required this.parentKey,
      required this.unitKey,
      required this.imageKey,
      required this.children,
      required this.price});

  void addChild(TreeNom child) {
    children.add(child);
  }

  factory TreeNom.toTreeNom(Nom nom) => TreeNom(
      id: 0,
      ref: nom.ref,
      isFolder: nom.isFolder,
      description: nom.description,
      article: nom.article,
      parentKey: nom.parentKey,
      unitKey: nom.unitKey,
      imageKey: nom.imageKey,
      children: [],
      price: nom.price);
}
