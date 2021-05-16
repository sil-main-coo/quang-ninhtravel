import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dulichquangninh/providers/models/diem_du_lich_model.dart';
import 'package:dulichquangninh/providers/repositories/diem_du_lich_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'diem_du_lich_event.dart';

part 'diem_du_lich_state.dart';

class DiemDuLichBloc extends Bloc<DiemDuLichEvent, DiemDuLichState> {
  DiemDuLichBloc({@required this.diemDuLichRepo})
      : super(DiemDuLichUnKnowState());

  final DiemDuLichRepo diemDuLichRepo;

  List<DiemDuLichModel> _diemDuLichs;

  @override
  Stream<DiemDuLichState> mapEventToState(
    DiemDuLichEvent event,
  ) async* {
    if (event is GetDiemDuLichData) {
      yield DiemDuLichUnKnowState();
      try {
        if (_diemDuLichs == null || _diemDuLichs.isEmpty)
          _diemDuLichs = await diemDuLichRepo.getAllDiemDuLich();
        yield DiemDuLichLoadedState(list: _diemDuLichs);
      } catch (e) {
        debugPrint(e.toString());
        yield DiemDuLichFailureState();
      }
    }
  }
}
