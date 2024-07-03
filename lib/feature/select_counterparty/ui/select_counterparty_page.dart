import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/common/common.dart';
import 'package:mobi_c/feature/select_counterparty/cubit/select_counterparty_cubit.dart';
import 'package:mobi_c/feature/select_counterparty/select_counterparty_client/select_counterparty_client.dart';
import 'package:mobi_c/feature/select_counterparty/select_counterparty_repo/select_counterparty_repo.dart';
import 'package:mobi_c/feature/select_counterparty/ui/list_nom_view.dart';
import 'package:mobi_c/services/data_base/object_box/models/models.dart';

class SelectCounterpartyPage extends StatelessWidget {
  const SelectCounterpartyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SelectCounterpartyCubit(
              SelectCounterpartyRepoImpl(
                  selectCounterpartyClient: SelectCounterpartyClient()),
            ),
        child: const SelectCounterpartyView());
  }
}

class SelectCounterpartyView extends StatefulWidget {
  const SelectCounterpartyView({super.key});

  @override
  State<SelectCounterpartyView> createState() => _SelectCounterpartyViewState();
}

class _SelectCounterpartyViewState extends State<SelectCounterpartyView> {
  SearchType searchType = SearchType.folder;
  String parentKey = '';
  @override
  void initState() {
    context.read<SelectCounterpartyCubit>().getFolders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        final onSelect =
        ModalRoute.of(context)!.settings.arguments as Function(Counterparty nom);
 
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: onPop, icon: const Icon(Icons.arrow_back)),
        centerTitle: false,
        title: const Row(
          children: [
            Icon(Icons.person_search),
            SizedBox(width: 8),
            Text('Клієнти'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_add),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                BlocBuilder<SelectCounterpartyCubit, SelectCounterpartyState>(
              builder: (context, state) {
                return ListView(
                  children: state.counterpartyTree
                      .map((item) => buildNode(item, context))
                      .toList(),
                );
              },
            ),
          ),
          if (searchType.isTextField)
            ListCounterpartyView(
              onSelect: onSelect,
              parentKey: parentKey,
            ),
        ],
      ),
    );
  }

  void onPop() {
    if (searchType.isFolder) Navigator.pop(context);
    context.read<SelectCounterpartyCubit>().clearCounterparty();
    setState(() => searchType = SearchType.folder);
  }

  Widget buildNode(CounterpartyTree node, BuildContext context) {
    if (node.children.isEmpty) {
      return ListTile(
        leading: const Icon(Icons.folder),
        title: Text(node.description),
        onTap: () {
            setState(() {
            parentKey = node.refKey;
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



class CounterpartyListItem extends StatelessWidget {
  final Counterparty counterparty;
  final Function(Counterparty) onSelect;

  const CounterpartyListItem({
    super.key,
    required this.counterparty,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () => onSelect(counterparty),
        title: Text(counterparty.description),
        subtitle: Text(counterparty.fullDescription),
      ),
    );
  }
}
