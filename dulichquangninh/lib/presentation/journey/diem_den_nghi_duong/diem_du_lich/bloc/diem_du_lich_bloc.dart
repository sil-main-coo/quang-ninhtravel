import 'package:bloc/bloc.dart';
import 'package:dulichquangninh/providers/models/diem_du_lich_model.dart';
import 'package:dulichquangninh/providers/repositories/diem_du_lich_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'diem_du_lich_event.dart';
part 'diem_du_lich_state.dart';

class DiemDuLichBloc extends Bloc<DiemDuLichEvent, DiemDuLichState> {
  final DiemDuLichRepo diemDuLichRepo;

  /// cache dữ liệu
  List<DiemDuLichModel> _diemDuLichs = [];

  DiemDuLichBloc({required this.diemDuLichRepo})
      : super(const DiemDuLichUnknownState()) {
    on<GetDiemDuLichData>(_onGetDiemDuLichData);
  }

  Future<void> _onGetDiemDuLichData(
      GetDiemDuLichData event,
      Emitter<DiemDuLichState> emit,
      ) async {
    emit(const DiemDuLichUnknownState());

    try {
      if (_diemDuLichs.isEmpty) {
        _diemDuLichs = await diemDuLichRepo.getAllDiemDuLich();
      }
      emit(DiemDuLichLoadedState(list: _diemDuLichs));
    } catch (e, s) {
      debugPrint('GetDiemDuLichData error: $e');
      debugPrintStack(stackTrace: s);
      emit(const DiemDuLichFailureState());
    }
  }
}
