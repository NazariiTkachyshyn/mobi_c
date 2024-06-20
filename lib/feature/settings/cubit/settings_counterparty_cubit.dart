import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/common/models/models.dart';
import 'package:mobi_c/feature/settings/settings_repo/settings_repo.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

part 'settings_counterparty_state.dart';

class SettingsCounterpartyCubit extends Cubit<SettingsCounterpartyState> {
  SettingsCounterpartyCubit(this._settingsRepo)
      : super(const SettingsCounterpartyState());

  final SettingsRepo _settingsRepo;

  Future<void> getRoutes() async {
    try {
      final routes = await _settingsRepo.getRoutes();
      emit(state.copyWith(
          routes: routes, status: SettingsCounterpartyStatus.success));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteRoute(int id) async {
    try {
      await _settingsRepo.deleteRoute(id);
      await getRoutes();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> insertRoute(
    CounterpartyTree counterparty,
  ) async {
    try {
      final route = ClientRoute(
        refKey: counterparty.refKey,
        description: counterparty.path.join(' ->\n'),
      );
      await _settingsRepo.insertRoute(route);
      await getRoutes();
    } catch (e) {
      throw Exception(e);
    }
  }

  changeView() => emit(state.copyWith(isTreeView: !state.isTreeView));

  getFolders() async {
    try {
      var folders = await _settingsRepo.getFolders();
      buildTree(folders);
    } catch (e) {
      emit(state.copyWith(status: SettingsCounterpartyStatus.failure));
    }
  }

  buildTree(List<Counterparty> folders) {
    final Map<String, CounterpartyTree> map = {};
    final List<CounterpartyTree> roots = [];

    final noms =
        folders.map((e) => CounterpartyTree.fromCounterparty(e)).toList();

    for (var nom in noms) {
      map[nom.refKey] = nom;
    }

    for (var nom in noms) {
      if (nom.isFolder &&
          nom.parentKey == '00000000-0000-0000-0000-000000000000') {
        roots.add(nom);
      } else {
        map[nom.parentKey]?.addChild(nom);
      }
    }
    emit(state.copyWith(counterpartyTree: roots));
  }
}
