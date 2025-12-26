import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dulichquangninh/providers/models/di_tich_model.dart';
import 'package:dulichquangninh/providers/models/loai_di_tich_model.dart';
import 'package:dulichquangninh/providers/repositories/di_tich_repo.dart';
import 'package:dulichquangninh/providers/repositories/image_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final DiTichRepo diTichRepo;
  final ImageRepo imageRepo;

  AppBloc({required this.diTichRepo, required this.imageRepo})
      : super(AppDataUnKnowState()) {
    on<GetApplicationData>(_onGetApplicationData);
  }

  Future<void> _onGetApplicationData(
    GetApplicationData event,
    Emitter<AppState> emit,
  ) async {
    try {
      final listDiTich = await diTichRepo.getAllDiTich();
      final coverImages = await imageRepo.getCoverImages();

      final khaiQuatMenu =
          listDiTich.keys.firstWhere((element) => element.tag == 'khai-quat');
      final khaiQuatList = listDiTich[khaiQuatMenu];

      listDiTich.remove(khaiQuatMenu);

      emit(AppDataLoadedState(
          mapDiTichs: listDiTich,
          khaiQuat: (menu: khaiQuatMenu, list: khaiQuatList ?? []),
          coverImages: coverImages));
    } catch (e) {
      print('>> e: $e');
    }
  }
}
