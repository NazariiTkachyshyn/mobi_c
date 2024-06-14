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
      if (parentKey.isNotEmpty) {
        final noms = await _selectNomRepo.searchNomsInFolder(value, parentKey);
        emit(state.copyWith(
            searchNoms: noms.reversed.toList(),
            status: SelectNomStatus.success));
        return;
      }
      final noms = await _selectNomRepo.getByDescription(value);
      emit(state.copyWith(
          searchNoms: noms.reversed.toList(), status: SelectNomStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
    }
  }



  Future<void> getNomsByParentKey(String parentkey) async {
    try {
      if (parentkey.isEmpty) return;
      final noms = await _selectNomRepo.getNomsByParentKey(parentkey);
      emit(state.copyWith(searchNoms: noms, status: SelectNomStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
      rethrow;
    }
  }

  buildTree(List<Nom> folders) {
    final noms = folders.map((e) => TreeNom.fromNom(e)).toList();
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

    for (var nom in noms) {
      map[nom.ref] = nom;
    }

    for (var nom in noms) {
      if (nom.isFolder &&
          (nom.ref == 'd1a81622-d0a2-11e1-9a25-c24921fc8a30' ||
              nom.ref == '08f6f5d4-24c0-11e1-b235-3e32ff0a5e79' ||
              nom.ref == '35e3c75c-24bf-11e1-b235-3e32ff0a5e79')) {
        roots.add(nom);
      } else {
        map[nom.parentKey]?.addChild(nom);
      }
    }
    emit(state.copyWith(treeNom: roots));
  }
}
