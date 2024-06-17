import 'package:get_it/get_it.dart';
import 'package:mobi_c/clients/odata_api_clients/odata_api_client.dart';
import 'package:mobi_c/feature/create_order/create_order_client/cerate_order_client.dart';
import 'package:mobi_c/feature/create_order/create_order_repo/create_order_repo.dart';
import 'package:mobi_c/feature/create_order/cubit/create_order_cubit.dart';
import 'package:mobi_c/feature/create_order/ui/ather_view.dart';
import 'package:mobi_c/feature/create_order/ui/counterparty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/feature/create_order/ui/product_view.dart';
import 'package:mobi_c/services/data_sync_service/data_sync_service.dart';

class CreateOrderPage extends StatelessWidget {
  const CreateOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CreateOrderCubit(CreateOrderRepoImpl(
            createOrderClient: CreateOrderClient(),
            odataApiClient: GetIt.I.get<OdataApiClient>())),
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.note_alt_outlined),
          centerTitle: false,
          title: const Text('Замовлення'),
          actions: [
            IconButton(
                onPressed: () async {
                  DataSyncService().downloadImage();
                  // DataSyncService().syncDiscountData();
                  // DataSyncService().syncNomData();
                  // DataSyncService().syncCounterpartyData();
                  // DataSyncService().syncContractData();
                  // DataSyncService().syncUnitData();
                },
                icon: const Icon(Icons.sync)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_sharp)),
          ],
          bottom: TabBar(
            controller: tabController,
            onTap: (value) {
              final state = context.read<CreateOrderCubit>().state;

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
    );
  }
}
