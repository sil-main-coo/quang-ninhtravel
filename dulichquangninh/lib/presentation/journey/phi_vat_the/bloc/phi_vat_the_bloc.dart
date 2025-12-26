import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dulichquangninh/providers/models/dac_san_model.dart';
import 'package:dulichquangninh/providers/models/phi_vat_the_model.dart';
import 'package:dulichquangninh/providers/repositories/dac_san_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../providers/repositories/phi_vat_the_repo.dart';

part 'phi_vat_the_event.dart';

part 'phi_vat_the_state.dart';

class PhiVatTheBloc extends Bloc<PhiVatTheEvent, PhiVatTheState> {
  PhiVatTheBloc({required this.phiVatTheRepo}) : super(PhiVatTheUnKnowState()) {
    // BẮT BUỘC: Đăng ký event handler cho Flutter 3.x
    on<GetPhiVatTheData>(_onGetDacSanData);
  }

  final PhiVatTheRepo phiVatTheRepo;

  Future<void> _onGetDacSanData(
    GetPhiVatTheData event,
    Emitter<PhiVatTheState> emit,
  ) async {
    emit(PhiVatTheUnKnowState());
    try {
      final data = await phiVatTheRepo.getAllPhiVatThe();

      emit(PhiVatTheLoadedState(phiVatThes: data));
    } catch (e) {
      debugPrint(e.toString());
      emit(PhiVatTheFailureState());
    }
  }
}
