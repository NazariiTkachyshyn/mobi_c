import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/feature/select_counterparty/cubit/select_counterparty_cubit.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

class ListCounterpartyView extends StatefulWidget {
  const ListCounterpartyView({
    super.key,
    required this.onSelect,
    required this.parentKey,
  });
  final Function(Counterparty counterparty) onSelect;
  final String parentKey;

  @override
  State<ListCounterpartyView> createState() => _ListCounterpartyViewState();
}

class _ListCounterpartyViewState extends State<ListCounterpartyView> {
  final scrollController = ScrollController();
  final textController = TextEditingController();
  @override
  void initState() {
    context.read<SelectCounterpartyCubit>().getByParentKey(widget.parentKey);

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        context
            .read<SelectCounterpartyCubit>()
            .getByParentKey(widget.parentKey);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SelectCounterpartyCubit, SelectCounterpartyState>(
          builder: (context, state) {
            final counterpartys = state.counterparty;
            return Column(
              children: [
                TextField(
                  controller: textController,
                  onChanged: (value) => context
                      .read<SelectCounterpartyCubit>()
                      .searchInFolder(value, widget.parentKey),
                  decoration: const InputDecoration(labelText: 'Назва'),
                ),
                const Padding(padding: EdgeInsets.all(4)),
                Expanded(
                    child: ListView.builder(
                  controller: scrollController,
                  itemCount: counterpartys.length,
                  itemBuilder: (context, index) {
                    final counterparty = counterpartys[index];
                    return _ListViewItem(
                      counterparty: counterparty,
                      onSelect: widget.onSelect,
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

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    required this.counterparty,
    required this.onSelect,
  });
  final Counterparty counterparty;
  final Function(Counterparty counterparty) onSelect;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8)),
        child: ListTile(
            visualDensity: const VisualDensity(vertical: 3),
            title: Text(
              counterparty.description,
              style: textTheme.titleMedium,
            ),
            subtitle: Text(counterparty.fullDescription),
            onTap: () => onSelect(counterparty)));
  }
}
