import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dulichquangninh/providers/models/dac_san_model.dart';
import 'package:dulichquangninh/providers/repositories/dac_san_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'dac_san_event.dart';

part 'dac_san_state.dart';

class DacSanBloc extends Bloc<DacSanEvent, DacSanState> {
  DacSanBloc({required this.dacSanRepo}) : super(DacSanUnKnowState()) {
    // BẮT BUỘC: Đăng ký event handler cho Flutter 3.x
    on<GetDacSanData>(_onGetDacSanData);
  }

  final DacSanRepo dacSanRepo;
  List<DacSanModel> _dacsans = []; // Khởi tạo rỗng thay vì late + null check

  Future<void> _onGetDacSanData(
    GetDacSanData event,
    Emitter<DacSanState> emit,
  ) async {
    emit(DacSanUnKnowState());
    try {
      if (_dacsans.isEmpty) {
        _dacsans = await dacSanRepo.getAllDacSan();
      }
      emit(DacSanLoadedState(dacsans: _dacsans));
    } catch (e) {
      debugPrint(e.toString());
      emit(DacSanFailureState());
    }
  }
}
