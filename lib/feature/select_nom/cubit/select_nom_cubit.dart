import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/feature/select_nom/select_nom_repo/select_nom_repo.dart';
import 'package:mobi_c/services/data_bases/object_box/models/models.dart';

part 'select_nom_state.dart';

class SelectNomCubit extends Cubit<SelectNomState> {
  SelectNomCubit(this._selectNomRepo) : super(const SelectNomState());

  final SelectNomRepo _selectNomRepo;

  getFolders() async {
    try {
      var folders = await _selectNomRepo.getFolders();
      buildTree(folders);
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
    }
  }

  Future<void> searchNomsInFolder(String value, String parentKey) async {
    try {
      final noms = await _selectNomRepo.searchNomsInFolder(value, parentKey);
      emit(state.copyWith(
          searchNoms: noms.reversed.toList(), status: SelectNomStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
    }
  }

  Future<void> getNomsByParentKey(String parentkey) async {
    try {
      final newNom =
          await _selectNomRepo.getNomsByParentKey(parentkey, state.offset);
      List<Nom> noms = List.of(state.searchNoms);
      noms.addAll(newNom.reversed);
      emit(state.copyWith(searchNoms: noms, status: SelectNomStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
      rethrow;
    }
  }

  buildTree(List<Nom> folders) {
    final Map<String, TreeNom> map = {};
    final List<TreeNom> roots = [
      TreeNom(
          id: 0,
          ref: '',
          isFolder: true,
          description: 'Показати все',
          article: '',
          parentKey: '',
          unitKey: '',
          imageKey: '',
          children: [],
          price: 0)
    ];

    //ref папок нижнього рівня
    final List<String> specialRefs = [
      'd1a81622-d0a2-11e1-9a25-c24921fc8a30',
      '08f6f5d4-24c0-11e1-b235-3e32ff0a5e79',
      '35e3c75c-24bf-11e1-b235-3e32ff0a5e79'
    ];

    for (var e in folders) {
      final nom = TreeNom.fromNom(e);
      map[nom.ref] = nom;

      if (nom.isFolder && specialRefs.contains(nom.ref)) {
        roots.add(nom);
      } else {
        map[nom.parentKey]?.addChild(nom);
      }
    }

    emit(state.copyWith(treeNom: roots));
  }

  clearNom() => emit(state.copyWith(searchNoms: []));
}
