part of 'hoi_nhap_bloc.dart';

abstract class HoiNhapEvent extends Equatable {
  const HoiNhapEvent();
}

class GetHoiNhapData extends HoiNhapEvent {
  final ({LoaiDiTichModel menu, List<DiTichModel> list}) khaiQuat;

  const GetHoiNhapData({required this.khaiQuat});

  @override
  List<Object> get props => [khaiQuat];
}
