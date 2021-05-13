import 'package:dulichquangninh/providers/data_sources/remote/di_tich_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/image_storage_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/loai_di_tich_source.dart';
import 'package:dulichquangninh/providers/models/di_tich_model.dart';
import 'package:dulichquangninh/providers/models/loai_di_tich_model.dart';
import 'package:flutter/cupertino.dart';

abstract class DiTichRepo {
  Future<Map<LoaiDiTichModel, List<DiTichModel>>> getAllDiTich();
}

class DiTichRepoImpl implements DiTichRepo {
  final DiTichSource diTichSource;
  final LoaiDiTichSource loaiDiTichSource;
  final ImageStorageSource imageStorageSource;

  DiTichRepoImpl(
      {@required this.diTichSource,
      @required this.loaiDiTichSource,
      @required this.imageStorageSource});

  @override
  Future<Map<LoaiDiTichModel, List<DiTichModel>>> getAllDiTich() async {
    Map<LoaiDiTichModel, List<DiTichModel>> map = {};

    final loaiDiTichs = await loaiDiTichSource.getLoaiDiTichs();

    for (var diTich in loaiDiTichs) {
      map[diTich] = await diTichSource.getDiTichByType(diTich.tag);
    }

    return map;
  }
}
