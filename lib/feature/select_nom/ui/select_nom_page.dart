import 'package:mobi_c/common/common.dart';
import 'package:mobi_c/feature/input_qty_unit/client/client.dart';
import 'package:mobi_c/feature/input_qty_unit/cubit/input_qty_unit_cubit.dart';
import 'package:mobi_c/feature/select_nom/cubit/select_nom_cubit.dart';
import 'package:mobi_c/feature/select_nom/select_nom_client/select_nom_client.dart';
import 'package:mobi_c/feature/select_nom/select_nom_repo/select_nom_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/feature/select_nom/ui/list_nom_view.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';


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
          leading:
              IconButton(onPressed: onPop, icon: const Icon(Icons.arrow_back)),
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
                  return ListView(
                    children: state.treeNom
                        .map((item) => buildNode(item, context))
                        .toList(),
                  );
                },
              ),
            ),
            searchType.isTextField
                ? ListNomView(
                    onSelect: onSelect,
                    parentKey: parentKey,
                    discount: discount,
                  )
                : const SizedBox()
          ],
        ));
  }

  void onPop() {
    if (searchType.isFolder) {
      Navigator.pop(context);
    }
    context.read<SelectNomCubit>().getFolders();

    searchType = SearchType.folder;
    setState(() {});
  }

  Widget buildNode(TreeNom node, BuildContext context) {
    if (node.children.isEmpty) {
      return ListTile(
        leading: const Icon(Icons.folder),
        title: Text(node.description),
        onTap: () {
          setState(() {
            parentKey = node.ref;
            searchType =
                searchType.isFolder ? SearchType.textField : SearchType.folder;
          });
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
