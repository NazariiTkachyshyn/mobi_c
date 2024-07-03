import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_c/auth/bloc/auth_bloc.dart';
import 'package:mobi_c/common/ui/widgets/widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Налаштування'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
            child: Text(
              'Основні',
              style: theme.textTheme.titleMedium,
            ),
          ),
          ListTile(
              leading: const Icon(Icons.sync),
              title: const Text('Синхронізація'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => Navigator.pushNamed(context, 'sync')),
          const Divider(
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            leading: const Icon(Icons.person_search_outlined),
            title: const Text('Налаштування маршрутів'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () =>
                Navigator.pushNamed(context, 'settings_counterparty_view'),
          ),
          const Spacer(),
          ListTile(
              leading: const SizedBox(
                width: 24,
              ),
              title: const Text('Вийти'),
              trailing: Icon(
                Icons.exit_to_app_rounded,
                color: Colors.red[900],
              ),
              onTap: () => showCheckDialog(
                    context,
                    title: 'Вихід',
                    description:
                        'Ви впевнені, що хочете вийти з акаунту.',
                    onPressedAccept: () => context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested()),
                  )),
        ],
      ),
    );
  }
}
