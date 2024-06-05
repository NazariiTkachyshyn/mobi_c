import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/feature/select_nom/select_nom_repo/select_nom_repo.dart';
import 'package:mobi_c/models/models.dart';

part 'select_nom_state.dart';

class SelectNomCubit extends Cubit<SelectNomState> {
  SelectNomCubit(this._selectNomRepo) : super(const SelectNomState());

  final SelectNomRepo _selectNomRepo;

  getFolders() async {
    try {
      var folders = await _selectNomRepo.getFolders();
      emit(state.copyWith(folders: folders, status: SelectNomStatus.success));
      return folders;
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
    }
  }

  Future<void> getAllNoms() async {
    try {
      final noms = await _selectNomRepo.getAllNoms();
      emit(state.copyWith(noms: noms, status: SelectNomStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
    }
  }

  Future<void> getNomsInFolder(String value) async {
    final noms = state.noms
        .where((e) =>
            (e.article.toLowerCase()).contains(value.toLowerCase()) ||
            (e.description.toLowerCase()).contains(value.toLowerCase()))
        .toList();
    try {
      emit(state.copyWith(searchNoms: noms, status: SelectNomStatus.success));
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
}
