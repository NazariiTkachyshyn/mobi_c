import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobi_c/auth/bloc/auth_bloc.dart';
import 'package:mobi_c/auth/user_repository.dart';
import 'package:mobi_c/clients/odata_api_clients/odata_api_client.dart';
import 'package:mobi_c/common/config/config_repo/config_repo.dart';
import 'package:mobi_c/common/config/cubit/config_cubit.dart';
import 'package:mobi_c/feature/create_order/ui/create_order_page.dart';
import 'package:mobi_c/feature/home_page/ui/home_page.dart';
import 'package:mobi_c/feature/login/ui/login_page.dart';
import 'package:mobi_c/feature/select_counterparty/ui/select_counterparty_page.dart';
import 'package:mobi_c/feature/select_nom/ui/select_nom_page.dart';
import 'package:mobi_c/feature/settings/cubit/settings_cubit.dart';
import 'package:mobi_c/feature/settings/ui/settings_page.dart';
import 'package:mobi_c/feature/settings/ui/pages/counterparty_page/counterparty_page.dart';
import 'package:mobi_c/feature/settings/ui/pages/views.dart';
import 'package:mobi_c/objectbox.g.dart';
import 'package:mobi_c/repository/authentication_repository/authentication_repository.dart';
import 'package:mobi_c/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'services/data_bases/object_box/object_box.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final Directory docDir = await getApplicationDocumentsDirectory();

  objectbox = await ObjectBox.create();

  final store = objectbox.store;

  final odataApiClient = OdataApiClient();

  GetIt.instance.registerSingleton<Store>(store);
  GetIt.instance.registerSingleton<OdataApiClient>(odataApiClient);
  GetIt.instance.registerSingleton<Directory>(docDir);

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => ConfigCubit(ConfigRepo()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('uk')],
        locale: const Locale('uk'),
        theme: AppTheme.light,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) async {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator.pushNamedAndRemoveUntil<void>(
                    '/',
                    (route) => false,
                  );
                  context.read<ConfigCubit>().getConfig();

                case AuthenticationStatus.unauthenticated:
                  _navigator.pushNamedAndRemoveUntil<void>(
                    'login',
                    (route) => false,
                  );
                case AuthenticationStatus.unknown:
                  break;
              }
            },
            child: child,
          );
        },

        // onGenerateRoute: (_) => SplashPage.route(),
        routes: {
          '/': (context) => const HomePage(),
          'login': (context) => const LoginPage(),
          'settings': (context) => const SettingsPage(),
          'sync': (context) => const SyncPage(),
          'settings_counterparty_view': (context) =>
              const SettingsCounterpartyPage(),
          'createOrderPage': (context) => const CreateOrderPage(),
          'selectCounterparty': (context) => const SelectCounterpartyPage(),
          'selectNom': (context) => const SelectNomPage()
        },
      ),
    );
  }
}
