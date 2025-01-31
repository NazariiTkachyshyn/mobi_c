import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/common/common.dart';
import 'package:mobi_c/feature/select_counterparty/select_counterparty_repo/select_counterparty_repo.dart';
import 'package:mobi_c/services/data_base/object_box/models/models.dart';

part 'select_counterparty_state.dart';

class SelectCounterpartyCubit extends Cubit<SelectCounterpartyState> {
  SelectCounterpartyCubit(this._selectCounterpartyRepo)
      : super(const SelectCounterpartyState());

  final SelectCounterpartyRepo _selectCounterpartyRepo;

  getFolders() async {
    try {
      var folders = await _selectCounterpartyRepo.getFolders();
      final routes = await _selectCounterpartyRepo.getRoutes();
      final routesIds = routes.map((e) => e.refKey).toList();
      buildTree(folders, routesIds);
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(status: SelectCounterpartyStatus.failure));
    }
  }

  Future<void> searchInFolder(String value, String parentKey) async {
    try {
      final counterparty =
          await _selectCounterpartyRepo.searchInFolder(value, parentKey);
      emit(state.copyWith(
          counterparty: counterparty.reversed.toList(),
          status: SelectCounterpartyStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectCounterpartyStatus.failure));
    }
  }

  Future<void> getByParentKey(String parentkey) async {
    try {
      final newcounterparty =
          await _selectCounterpartyRepo.getByParentKey(parentkey, state.offset);
      List<Counterparty> counterpartys = List.of(state.counterparty);
      counterpartys.addAll(newcounterparty.reversed);
      emit(state.copyWith(
          counterparty: counterpartys,
          status: SelectCounterpartyStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectCounterpartyStatus.failure));
      rethrow;
    }
  }

  buildTree(List<Counterparty> folders, List<String> routes) {
    final Map<String, CounterpartyTree> map = {};
    final List<CounterpartyTree> roots = [
      CounterpartyTree(
          refKey: '',
          description: 'Показати все',
          mainCounterpartyKey: '',
          partnerKey: '',
          fullDescription: '',
          searchField: '',
          parentKey: '',
          children: [],
          isFolder: true)
    ];

    final noms =
        folders.map((e) => CounterpartyTree.fromCounterparty(e)).toList();

    for (var nom in noms) {
      map[nom.refKey] = nom;
    }

    for (var nom in noms) {
      if (nom.isFolder && routes.contains(nom.refKey)) {
        roots.add(nom);
      } else {
        map[nom.parentKey]?.addChild(nom);
      }
    }
    emit(state.copyWith(counterpartyTree: roots));
  }

  clearCounterparty() => emit(state.copyWith(counterparty: []));
}
