import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/common/widgets/slidable_component.dart';
import 'package:mobi_c/feature/settings/cubit/settings_counterparty_cubit.dart';
import 'package:mobi_c/feature/settings/settings_client/settings_client.dart';
import 'package:mobi_c/feature/settings/settings_repo/settings_repo.dart';
import 'package:mobi_c/feature/settings/ui/pages/counterparty_page/counterparty_tree_view.dart';
import 'package:mobi_c/ui/components/widgets/text_field_button.dart';
import 'package:mobi_c/services/data_bases/object_box/models/route.dart' as ob;

class SettingsCounterpartyPage extends StatelessWidget {
  const SettingsCounterpartyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCounterpartyCubit(
        SettingsRepoImpl(settingsClient: SettingsClient()),
      ),
      child: const SettingsCounterpartyView(),
    );
  }
}

class SettingsCounterpartyView extends StatelessWidget {
  const SettingsCounterpartyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              final state = context.read<SettingsCounterpartyCubit>().state;
              if (state.isTreeView) {
                context.read<SettingsCounterpartyCubit>().changeView();
                return;
              }
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Маршрути'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFielButton(
                  lableText: 'Вибрати',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: const Icon(Icons.add),
                  onTap: () =>
                      context.read<SettingsCounterpartyCubit>().changeView(),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(child: BlocBuilder<SettingsCounterpartyCubit,
                    SettingsCounterpartyState>(
                  builder: (context, state) {
                    if (state.status.isInitial) {
                      context.read<SettingsCounterpartyCubit>().getRoutes();
                    }
                    return ListView.builder(
                        itemCount: state.routes.length,
                        itemBuilder: (context, index) {
                          final route = state.routes[index];
                          return SlidableComponent(
                              color: Colors.red,
                              icon: Icons.delete,
                              lable: 'Видалити',
                              onPressed: (_) => context
                                  .read<SettingsCounterpartyCubit>()
                                  .deleteRoute(route.id),
                              child: _ListViewItem(
                                route: route,
                              ));
                        });
                  },
                ))
              ],
            ),
          ),
          BlocBuilder<SettingsCounterpartyCubit, SettingsCounterpartyState>(
            builder: (context, state) {
              if (state.isTreeView) {
                return const CounterpartyTreeView();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem({
    required this.route,
  });
  final ob.ClientRoute route;

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
            route.description,
            style: textTheme.titleSmall,
          ),
        ));
  }
}
