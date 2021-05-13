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

  AppBloc({@required this.diTichRepo, @required this.imageRepo})
      : super(AppDataUnKnowState());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is GetApplicationData) {
      yield* _getAppData();
    }
  }

  Stream<AppState> _getAppData() async* {
    final listDiTich = await diTichRepo.getAllDiTich();
    final coverImages = await imageRepo.getCoverImages();

    print('>> cover: $coverImages');

    yield AppDataLoadedState(mapDiTichs: listDiTich, coverImages: coverImages);
  }
}
