import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dulichquangninh/providers/models/dac_san_model.dart';
import 'package:dulichquangninh/providers/models/di_tich_model.dart';
import 'package:dulichquangninh/providers/models/loai_di_tich_model.dart';
import 'package:dulichquangninh/providers/repositories/dac_san_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'hoi_nhap_event.dart';

part 'hoi_nhap_state.dart';

class HoiNhapBloc extends Bloc<HoiNhapEvent, HoiNhapState> {
  HoiNhapBloc({required this.dacSanRepo}) : super(HoiNhapUnKnowState()) {
    on<GetHoiNhapData>(_onGetDacSanData);
  }

  final DacSanRepo dacSanRepo;

  Future<void> _onGetDacSanData(
    GetHoiNhapData event,
    Emitter<HoiNhapState> emit,
  ) async {
    emit(HoiNhapUnKnowState());
    try {
      final dacsans = await dacSanRepo.getAllDacSan();

      debugPrint('DacSan length = ${dacsans.length}');

      emit(HoiNhapLoadedState(dacsans: dacsans, khaiQuat: event.khaiQuat));
    } catch (e) {
      debugPrint(e.toString());
      emit(HoiNhapFailureState());
    }
  }
}
