import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobi_c/common/func.dart';
import 'package:mobi_c/feature/input_qty_unit/client/client.dart';
import 'package:mobi_c/feature/input_qty_unit/cubit/input_qty_unit_cubit.dart';
import 'package:mobi_c/feature/input_qty_unit/ui/count_input_dialog.dart';
import 'package:mobi_c/feature/select_nom/cubit/select_nom_cubit.dart';
import 'package:mobi_c/feature/select_nom/select_nom_client/select_nom_client.dart';
import 'package:mobi_c/feature/select_nom/select_nom_repo/select_nom_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';
import 'package:path_provider/path_provider.dart';

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
    return MultiBlocProvider(providers: [
      BlocProvider(
          create: (context) => SelectNomCubit(
              SelectNomRepoImpl(selectNomClient: SelectNomClient()))),
      BlocProvider(create: (context) => InputQtyUnitCubit(InputQtyUnitClient()))
    ], child: const SelectNomView());
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
    context.read<SelectNomCubit>().getImage('');

    super.initState();
  }

  @override
  Widget build(context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final onSelect =
        arguments['onTap'] as Function(Nom nom, String qty, Unit unit);
    final discount = arguments['discount'];
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<SelectNomCubit, SelectNomState>(
                listener: (context, state) {},
                builder: (context, state) {
                  List<TreeNom> treeData = buildTree(
                      state.folders.map((e) => TreeNom.toTreeNom(e)).toList());

                  return ListView(
                    children: treeData
                        .map((item) => buildNode(item, context))
                        .toList(),
                  );
                },
              ),
            ),
            searchType.isTextField
                ? _SearchByTextField(
                    onSelect: onSelect,
                    parentKey: parentKey,
                    discount: discount,
                  )
                : const SizedBox()
          ],
        ));
  }

  Widget buildNode(TreeNom node, BuildContext context) {
    if (node.children.isEmpty) {
      return ListTile(
        leading: const Icon(Icons.folder),
        title: Text(node.description),
        onTap: () {
          if (node.ref.isEmpty) {}

          parentKey = node.ref;
          searchType =
              searchType.isFolder ? SearchType.textField : SearchType.folder;

          setState(() {});
        },
      );
    } else {
      return ExpansionTile(
        shape: const OutlineInputBorder(borderSide: BorderSide.none),
        leading: const Icon(Icons.folder_copy),
        title: Text(node.description),
        children: node.children
            .map((child) => Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: buildNode(child, context),
                ))
            .toList(),
      );
    }
  }
}

class _SearchByTextField extends StatefulWidget {
  const _SearchByTextField(
      {required this.onSelect,
      required this.parentKey,
      required this.discount});
  final Function(Nom nom, String qty, Unit init) onSelect;
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

  ActionPane actionPane(Nom nom) {
    return ActionPane(motion: const DrawerMotion(), children: [
      SlidableAction(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        flex: 2,
        onPressed: (value) {
          showModal(
              context: context,
              builder: (_) => BlocProvider.value(
                    value: context.read<InputQtyUnitCubit>(),
                    child: InputQtyUnitDialog(
                      nom: nom,
                      onPressedContiniue: (qty, unit) {
                        widget.onSelect(nom, qty, unit);
                        Navigator.pop(context);
                      },
                    ),
                  ));
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: Icons.add,
        label: 'Додати',
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Future<File> _getLocalFile(String filename) async {
      final docDir = await getApplicationDocumentsDirectory();
      final imageDir = Directory(docDir.path+"/images");
      File f = File('${imageDir.path}/$filename');
      final files = imageDir.listSync(recursive: true, followLinks: false);
      print(files.length);

      return f;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<SelectNomCubit, SelectNomState>(
          listener: (context, state) {},
          builder: (context, state) {
            final noms = state.searchNoms;
            return Column(
              children: [
                TextField(
                  onChanged: (value) {
                    if (widget.parentKey.isEmpty) {
                      context.read<SelectNomCubit>().getByDescription(value);
                      return;
                    }
                    context
                        .read<SelectNomCubit>()
                        .searchNomsInFolder(value, widget.parentKey);
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
                      child: Slidable(
                        endActionPane: actionPane(nom),
                        startActionPane: actionPane(nom),
                        child: ListTile(
                          visualDensity: const VisualDensity(vertical: 3),
                          leading: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 44,
                                minHeight: 44,
                                maxWidth: 64,
                                maxHeight: 64,
                              ),
                              child: FutureBuilder(
                                  future: _getLocalFile(nom.ref),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<File> snapshot) {
                                    try {
                                      return Image.file(
                                        snapshot.data!,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Icon(
                                          Icons.image_search_rounded,
                                          color: Colors.grey,
                                          size: 50,
                                        ),
                                      );
                                    } catch (e) {
                                      return Icon(
                                          Icons.image_not_supported_rounded);
                                    }
                                  })
                              // Image.file(file)
                              ),
                          onTap: () {
                            qtyInputDialog(context, nom, widget.onSelect);
                          },
                          title: Text(
                            nom.article,
                            style: theme.textTheme.titleMedium,
                          ),
                          subtitle: Text(nom.description),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  '${calcDiscount(nom.price, widget.discount).toStringAsFixed(2)} грн.',
                                  style: theme.textTheme.labelLarge!
                                      .copyWith(color: Colors.black)),
                              Text('${nom.price.toStringAsFixed(2)} грн.',
                                  style: theme.textTheme.labelLarge!
                                      .copyWith(color: Colors.grey)),
                              Text(
                                nom.remaining.toString(),
                                style: theme.textTheme.labelLarge!
                                    .copyWith(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ))
              ],
            );
          },
        ),
      ),
    );
  }
}

qtyInputDialog(BuildContext context, Nom nom,
    Function(Nom nom, String qty, Unit init) onSelect) {
  showModal(
      context: context,
      builder: (_) => BlocProvider.value(
            value: context.read<InputQtyUnitCubit>(),
            child: InputQtyUnitDialog(
              nom: nom,
              onPressedContiniue: (qty, unit) {
                onSelect(nom, qty, unit);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ));
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
      price: 0);
}
