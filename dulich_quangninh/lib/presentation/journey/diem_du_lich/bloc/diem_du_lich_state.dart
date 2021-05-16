part of 'diem_du_lich_bloc.dart';

abstract class DiemDuLichState extends Equatable {
  const DiemDuLichState();
}

class DiemDuLichUnKnowState extends DiemDuLichState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DiemDuLichLoadedState extends DiemDuLichState {
  final List<DiemDuLichModel> list;

  DiemDuLichLoadedState({
    @required this.list,
  });

  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class DiemDuLichFailureState extends DiemDuLichState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
