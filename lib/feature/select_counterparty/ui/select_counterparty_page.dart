import 'package:mobi_c/feature/select_counterparty/cubit/select_counterparty_cubit.dart';
import 'package:mobi_c/feature/select_counterparty/select_counterparty_client/select_counterparty_client.dart';
import 'package:mobi_c/feature/select_counterparty/select_counterparty_repo/select_counterparty_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

class SelectCounterpartyPage extends StatelessWidget {
  const SelectCounterpartyPage({super.key});

  @override
  Widget build(context) {
    return BlocProvider(
        create: (context) => SelectCounterpartyCubit(SelectCounterpartyRepoImpl(
            selectCounterpartyClient: SelectCounterpartyClient())),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Row(
              children: [
                Icon(Icons.person_search),
                Text('Клієнти'),
              ],
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.person_add))
            ],
          ),
          body: const _SearchByTextField(),
        ));
  }
}

class _SearchByTextField extends StatelessWidget {
  const _SearchByTextField();

  @override
  Widget build(BuildContext context) {
    final onSelect = ModalRoute.of(context)!.settings.arguments as Function(
        Counterparty counterparty);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<SelectCounterpartyCubit, SelectCounterpartyState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            children: [
              TextField(
                onChanged: (value) => context
                    .read<SelectCounterpartyCubit>()
                    .searchCounterparty(value),
                decoration: const InputDecoration(labelText: 'Назва клієнта'),
              ),
              const Padding(padding: EdgeInsets.all(4)),
              Expanded(
                  child: ListView.builder(
                itemCount: state.counterparty.length,
                itemBuilder: (context, index) {
                  final counterparty = state.counterparty[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      onTap: () {
                        onSelect(counterparty);
                      },
                      title: Text(counterparty.description),
                      subtitle: Text(counterparty.fullDescription),
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
