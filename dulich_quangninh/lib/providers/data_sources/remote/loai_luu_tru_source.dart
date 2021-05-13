import 'package:dulichquangninh/common/constants/firebase_constants.dart';
import 'package:dulichquangninh/providers/models/loai_luu_tru_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class LoaiLuuTruSource {
  final _databaseReference = FirebaseDatabase.instance
      .reference()
      .child(FirebaseConstants.loaiLuuTruCollect);

  Future<List<LoaiLuuTruModel>> getLoaiLuuTrus() async {
    List<LoaiLuuTruModel> list = [];
    try {
      final snapshot = await _databaseReference.once();
      debugPrint('getLoaiLuuTrus : ${snapshot.value}');

      if (snapshot.value != null) {
        final map = Map<String, dynamic>.from(snapshot.value);
        final keys = map.keys;

        for (var key in keys) {
          final model = LoaiLuuTruModel.fromJson(map[key], tag: key);

          list.add(model);
        }
      }

      return list;
    } catch (e) {
      throw e;
    }
  }
}
