import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/common/common.dart';
import 'package:mobi_c/feature/settings/cubit/sync_cubit.dart';
import 'package:mobi_c/services/data_sync_service/clients/api_client.dart';
import 'package:mobi_c/services/data_sync_service/data_sync_service.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SyncCubit(DataSyncService(DataSyncApiClient())),
        child: const SyncView());
  }
}

class SyncView extends StatelessWidget {
  const SyncView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Синхронізація'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Синхронізувати базу даних'),
            onTap: () =>
                (context.read<SyncCubit>().syncDbData(), showDialogg(context)),
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            title: const Text('Завантажити фотографії'),
            onTap: () => context.read<SyncCubit>().downloadImage(),
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            title: const Text('Завантажити все'),
            onTap: () =>
                (context.read<SyncCubit>().syncAll(), showDialogg(context)),
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            title: const Text('Вивантажити замовлення'),
            onTap: () => (context.read<SyncCubit>().syncOrders()),
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            title: const Text('Вивантажити пко'),
            onTap: () => (),
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            title: const Text('Видалити базу даних'),
            onTap: () => showCheckDialog(
              context,
              title: 'Видалення бази даних',
              description:
                  'Ви впевнені, що хочете видалити базу даних? Цю дію не можна буде скасувати.',
              onPressedAccept: () => context.read<SyncCubit>().deleteAll(),
            ),
          ),
        ],
      ),
    );
  }
}

showDialogg(BuildContext context) {
  showModal(
    context: context,
    builder: (_) {
      return BlocProvider.value(
          value: context.read<SyncCubit>(),
          child: Dialog(
              child: SizedBox(
            width: 200,
            height: 320,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: BlocBuilder<SyncCubit, SyncState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: state.syncStatuses.length,
                      itemBuilder: (context, index) {
                        final status = state.syncStatuses[index];
                        return ListTile(
                          title: Text(status.dataType),
                          trailing: status.resultCode == 3
                              ? const Text('•••')
                              : const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                        );
                      },
                    );
                  },
                )),
          )));
    },
  );
}

String getResultMessage(int resultCode) {
  switch (resultCode) {
    case 0:
      return 'Не потребує оновлення';
    case 1:
      return 'Успішно оновлено';
    case 2:
      return 'Виникла помилка';
    default:
      return 'НЕВІДОМИЙ СТАТУС';
  }
}
