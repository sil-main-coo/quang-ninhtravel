import 'package:dulichquangninh/providers/data_sources/remote/loai_luu_tru_source.dart';
import 'package:dulichquangninh/providers/data_sources/remote/luu_tru_source.dart';
import 'package:dulichquangninh/providers/models/loai_luu_tru_model.dart';
import 'package:dulichquangninh/providers/models/luu_tru_model.dart';
import 'package:flutter/cupertino.dart';

  abstract class LuuTruRepo {
  Future<Map<LoaiLuuTruModel, List<LuuTruModel>>> getAllLuuTru();
}

class LuuTruRepoImpl implements LuuTruRepo {
  final LuuTruSource luuTruSource;
  final LoaiLuuTruSource loaiLuuTruSource;

  LuuTruRepoImpl(
      {@required this.luuTruSource, @required this.loaiLuuTruSource});

  @override
  Future<Map<LoaiLuuTruModel, List<LuuTruModel>>> getAllLuuTru() async {
    Map<LoaiLuuTruModel, List<LuuTruModel>> map = {};

    final loaiLuuTrus = await loaiLuuTruSource.getLoaiLuuTrus();

    for (var luuTru in loaiLuuTrus) {
      map[luuTru] = await luuTruSource.getLuuTruByType(luuTru.tag);
    }

    return map;
  }
}
