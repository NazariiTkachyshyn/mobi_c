import 'package:mobi_c/common/common.dart';
import 'package:mobi_c/feature/create_order/create_order_client/cerate_order_client.dart';
import 'package:mobi_c/feature/create_order/create_order_repo/create_order_repo.dart';
import 'package:mobi_c/feature/create_order/cubit/create_order_cubit.dart';
import 'package:mobi_c/feature/create_order/ui/ather_view.dart';
import 'package:mobi_c/feature/create_order/ui/counterparty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/feature/create_order/ui/product_view.dart';
import 'package:mobi_c/feature/settings/cubit/settings_cubit.dart';

class CreateOrderPage extends StatelessWidget {
  const CreateOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CreateOrderCubit(CreateOrderRepoImpl(
              createOrderClient: CreateOrderClient(),
            )),
        child: const _CreateOrderPage());
  }
}

class _CreateOrderPage extends StatefulWidget {
  const _CreateOrderPage();

  @override
  State<_CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<_CreateOrderPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    context.read<CreateOrderCubit>().createOrderId();
    context.read<CreateOrderCubit>().selectDatetime(DateTime.now());
    context.read<CreateOrderCubit>().getNoms();

    tabController = TabController(
        length: 3,
        vsync: this,
        animationDuration: const Duration(milliseconds: 100));

    // tabController.addListener(() {
    //   if (!tabController.indexIsChanging) {
    //     final state = context.read<CreateOrderCubit>().state;
    //     if (tabController.index != 0 &&
    //         state.counterparty == Counterparty.empty) {
    //       tabController.index = 0;
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text('Клієнта не вибрано.')),
    //       );
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return await showCheckDialog(
          context,
          onPressedAccept: () {
            Navigator.pop(context, true);
          },
          title: 'Закрити замовлення',
          description: 'Ви впевнені, що хочете закрити замовлення?',
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            leading: IconButton(
                onPressed: () => showCheckDialog(context,
                    onPressedAccept: () => Navigator.pop(context),
                    title: 'Закрити замовлення',
                    description: 'Ви впевнені, що хочете закрити замовлення?'),
                icon: const Icon(Icons.arrow_back)),
            title: BlocBuilder<CreateOrderCubit, CreateOrderState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Замовлення'),
                    Text(
                      '${state.discountedSumm.toStringAsFixed(2)} грн',
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                );
              },
            ),
            actions: [
              PopupMenuButton(
                icon: const Icon(Icons.more_vert_rounded),
                itemBuilder: (context) => [
                  const PopupMenuItem<ViewType>(
                    value: ViewType.listWithoutImages,
                    child: Text('Список без іконок'),
                  ),
                  const PopupMenuItem<ViewType>(
                    value: ViewType.listWithIcons,
                    child: Text('Список з іконками'),
                  ),
                  // const PopupMenuItem<ViewType>(
                  //   value: ViewType.thumbnails,
                  //   child: Text('Мініатюри'),
                  // ),
                ],
                onSelected: (value) =>
                    context.read<SettingsCubit>().changeViewType(value),
              )
            ],
            bottom: TabBar(
              controller: tabController,
              onTap: (value) {
                // final state = context.read<CreateOrderCubit>().state;

                // if (value != 0 && state.counterparty == Counterparty.empty) {
                //   tabController.index = 0;
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Клієнта не вибрано.')),
                //   );
                // }
              },
              tabs: const <Widget>[
                Tab(
                  text: 'КЛІЄНТ',
                ),
                Tab(
                  text: 'ТОВАРИ',
                ),
                Tab(
                  text: 'ІНШЕ',
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: const <Widget>[
              CounterpartyView(),
              ProductView(),
              AtherView(),
            ],
          ),
        ),
      ),
    );
  }
}
