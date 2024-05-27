import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/feature/select_nom/select_nom_repo/select_nom_repo.dart';
import 'package:mobi_c/models/models.dart';

part 'select_nom_state.dart';

class SelectNomCubit extends Cubit<SelectNomState> {
  SelectNomCubit(this._selectNomRepo) : super(const SelectNomState());

  final SelectNomRepo _selectNomRepo;

  getAllNoms() {
    try {
      final noms = _selectNomRepo.getAllNoms();
      emit(state.copyWith(noms: noms, status: SelectNomStatus.success));
      return noms;
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
    }
  }

  Future<void> getNoms(String value) async {
    try {
      final noms = await _selectNomRepo.getNoms(value);
      emit(state.copyWith(noms: noms, status: SelectNomStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
    }
  }

  Future<List<Nom>> getNomsByParentKey(String parentkey) async {
    try {
      final noms = await _selectNomRepo.getNomsByParentKey(parentkey);
      emit(state.copyWith(noms: noms, status: SelectNomStatus.success));
      return noms;
    } catch (e) {
      emit(state.copyWith(status: SelectNomStatus.failure));
      rethrow;
    }
  }
}
