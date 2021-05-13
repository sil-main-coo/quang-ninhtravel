import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dulichquangninh/providers/models/loai_luu_tru_model.dart';
import 'package:dulichquangninh/providers/models/luu_tru_model.dart';
import 'package:dulichquangninh/providers/repositories/luu_tru_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'luu_tru_event.dart';

part 'luu_tru_state.dart';

class LuuTruBloc extends Bloc<LuuTruEvent, LuuTruState> {
  LuuTruBloc({@required this.luuTruRepo}) : super(LuuTruUnKnowState());

  final LuuTruRepo luuTruRepo;

  @override
  Stream<LuuTruState> mapEventToState(
    LuuTruEvent event,
  ) async* {
    if (event is GetLuuTruData) {
      yield LuuTruUnKnowState();
      try {
        final luuTrus = await luuTruRepo.getAllLuuTru();
        yield LuuTruLoadedState(mapLuuTru: luuTrus);
      } catch (e) {
        yield LuuTruFailureState();
      }
    }
  }
}
