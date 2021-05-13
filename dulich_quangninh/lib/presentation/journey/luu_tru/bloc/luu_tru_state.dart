part of 'luu_tru_bloc.dart';

abstract class LuuTruState extends Equatable {
  const LuuTruState();
}

class LuuTruUnKnowState extends LuuTruState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LuuTruLoadedState extends LuuTruState {
  final Map<LoaiLuuTruModel, List<LuuTruModel>> mapLuuTru;

  LuuTruLoadedState({
    @required this.mapLuuTru,
  });

  @override
  // TODO: implement props
  List<Object> get props => [mapLuuTru];
}

class LuuTruFailureState extends LuuTruState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
