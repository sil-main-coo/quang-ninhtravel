part of 'hoi_nhap_bloc.dart';

abstract class HoiNhapState extends Equatable {
  const HoiNhapState();
}

class HoiNhapUnKnowState extends HoiNhapState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class HoiNhapLoadedState extends HoiNhapState {
  final List<DacSanModel> dacsans;
  final ({LoaiDiTichModel menu, List<DiTichModel> list}) khaiQuat;
  late int timestamp;

  HoiNhapLoadedState({
    required this.dacsans,
    required this.khaiQuat,
  }){
    timestamp = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  List<Object> get props => [dacsans, khaiQuat, timestamp];
}

class HoiNhapFailureState extends HoiNhapState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
