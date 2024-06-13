
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
      emit(state.copyWith(folders: folders, status: SelectNomStatus.success));
      return folders;
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
    }
  }

  Future<void> searchNomsInFolder(String value, String parentKey) async {
    try {
      final res = await _selectNomRepo.searchNomsInFolder(value, parentKey);
      final noms = res.length < 31 ? res : res.getRange(0, 30).toList();
      emit(state.copyWith(
          searchNoms: noms.reversed.toList(), status: SelectNomStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
    }
  }

  Future<void> getByDescription(String value) async {
    try {
      final res = await _selectNomRepo.getByDescription(value);
      final noms = res.length < 31 ? res : res.getRange(0, 30).toList();

      emit(state.copyWith(
          searchNoms: noms.reversed.toList(), status: SelectNomStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
      rethrow;
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

  Future<void> getImage(String ref) async {
    try {
      final images = await _selectNomRepo.getImage(ref);
      emit(state.copyWith(images: images, status: SelectNomStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
      rethrow;
    }
  }
}
