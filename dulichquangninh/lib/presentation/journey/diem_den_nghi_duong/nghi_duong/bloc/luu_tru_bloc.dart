import 'package:bloc/bloc.dart';
import 'package:dulichquangninh/providers/models/loai_luu_tru_model.dart';
import 'package:dulichquangninh/providers/models/luu_tru_model.dart';
import 'package:dulichquangninh/providers/repositories/luu_tru_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'luu_tru_event.dart';
part 'luu_tru_state.dart';

class LuuTruBloc extends Bloc<LuuTruEvent, LuuTruState> {
  final LuuTruRepo luuTruRepo;

  /// cache dữ liệu
  Map<LoaiLuuTruModel, List<LuuTruModel>> _mapLuuTru = {};

  LuuTruBloc({required this.luuTruRepo})
      : super(const LuuTruUnknownState()) {
    on<GetLuuTruData>(_onGetLuuTruData);
  }

  Future<void> _onGetLuuTruData(
      GetLuuTruData event,
      Emitter<LuuTruState> emit,
      ) async {
    emit(const LuuTruUnknownState());

    try {
      if (_mapLuuTru.isEmpty) {
        _mapLuuTru = await luuTruRepo.getAllLuuTru();
      }
      emit(LuuTruLoadedState(mapLuuTru: _mapLuuTru));
    } catch (e, s) {
      debugPrint('GetLuuTruData error: $e');
      debugPrintStack(stackTrace: s);
      emit(const LuuTruFailureState());
    }
  }
}
