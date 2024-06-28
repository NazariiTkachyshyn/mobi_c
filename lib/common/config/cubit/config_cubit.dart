import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobi_c/common/config/config_repo/config_repo.dart';
import 'package:mobi_c/common/models/config.dart';

part 'config_state.dart';

class ConfigCubit extends Cubit<ConfigState> {
  ConfigCubit(this._configRepo) : super(const ConfigState());
  final ConfigRepo _configRepo;
  getConfig() async {
    final res = await _configRepo.getConfigFromOb();
    emit(state.copyWith(
        dbConn: res.dbConn,
        imagesDb: res.imagesDb,
        keys: res.keys,
        storages: res.storages));
  }
}
