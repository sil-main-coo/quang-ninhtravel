part of 'luu_tru_bloc.dart';

abstract class LuuTruState extends Equatable {
  const LuuTruState();

  @override
  List<Object?> get props => [];
}

class LuuTruUnknownState extends LuuTruState {
  const LuuTruUnknownState();
}

class LuuTruLoadedState extends LuuTruState {
  final Map<LoaiLuuTruModel, List<LuuTruModel>> mapLuuTru;

  const LuuTruLoadedState({required this.mapLuuTru});

  @override
  List<Object?> get props => [mapLuuTru];
}

class LuuTruFailureState extends LuuTruState {
  const LuuTruFailureState();
}
