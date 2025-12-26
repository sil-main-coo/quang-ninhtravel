part of 'diem_du_lich_bloc.dart';

abstract class DiemDuLichState extends Equatable {
  const DiemDuLichState();

  @override
  List<Object?> get props => [];
}

class DiemDuLichUnknownState extends DiemDuLichState {
  const DiemDuLichUnknownState();
}

class DiemDuLichLoadedState extends DiemDuLichState {
  final List<DiemDuLichModel> list;

  const DiemDuLichLoadedState({required this.list});

  @override
  List<Object?> get props => [list];
}

class DiemDuLichFailureState extends DiemDuLichState {
  const DiemDuLichFailureState();
}
