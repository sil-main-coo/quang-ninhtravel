import 'package:dulichquangninh/providers/data_sources/remote/diem_du_lich_source.dart';
import 'package:dulichquangninh/providers/models/diem_du_lich_model.dart';
import 'package:flutter/cupertino.dart';

abstract class DiemDuLichRepo {
  Future<List<DiemDuLichModel>> getAllDiemDuLich();
}

class DiemDuLichRepoImpl implements DiemDuLichRepo {
  final DiemDuLichSource diemDuLichSource;

  DiemDuLichRepoImpl({
    @required this.diemDuLichSource,
  });

  @override
  Future<List<DiemDuLichModel>> getAllDiemDuLich() async {
    return await diemDuLichSource.getAllDiemDuLich();
  }
}
