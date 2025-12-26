part of 'diem_du_lich_bloc.dart';

abstract class DiemDuLichEvent extends Equatable {
  const DiemDuLichEvent();

  @override
  List<Object?> get props => [];
}

class GetDiemDuLichData extends DiemDuLichEvent {
  const GetDiemDuLichData();
}