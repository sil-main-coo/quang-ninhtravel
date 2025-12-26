part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppDataUnKnowState extends AppState {}

class AppDataLoadedState extends AppState {
  final Map<LoaiDiTichModel, List<DiTichModel>> mapDiTichs;
  final ({LoaiDiTichModel menu, List<DiTichModel> list}) khaiQuat;
  final List<String> coverImages;

  AppDataLoadedState({required this.mapDiTichs, required this.khaiQuat,required this.coverImages});

  @override
  // TODO: implement props
  List<Object> get props => [mapDiTichs, khaiQuat, coverImages];
}

class AppLoadFailureState extends AppState {}
