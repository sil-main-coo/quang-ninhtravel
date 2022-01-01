import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dulichquangninh/providers/models/dac_san_model.dart';
import 'package:dulichquangninh/providers/repositories/dac_san_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'dac_san_event.dart';

part 'dac_san_state.dart';

class DacSanBloc extends Bloc<DacSanEvent, DacSanState> {
  DacSanBloc({@required this.dacSanRepo}) : super(DacSanUnKnowState());

  final DacSanRepo dacSanRepo;

  List<DacSanModel> _dacsans;

  @override
  Stream<DacSanState> mapEventToState(
    DacSanEvent event,
  ) async* {
    if (event is GetDacSanData) {
      yield DacSanUnKnowState();
      try {
        if (_dacsans == null || _dacsans.isEmpty)
          _dacsans = await dacSanRepo.getAllDacSan();
        yield DacSanLoadedState(dacsans: _dacsans);
      } catch (e) {
        debugPrint(e.toString());
        yield DacSanFailureState();
      }
    }
  }
}
