part of 'settings_cubit.dart';

final class SettingsState extends Equatable {
  const SettingsState({this.viewType = ViewType.listWithIcons});

  final ViewType viewType;

  SettingsState copyWith({ViewType? viewType}) {
    return SettingsState(viewType: viewType ?? this.viewType);
  }

  @override
  List<Object?> get props => [viewType];
}
