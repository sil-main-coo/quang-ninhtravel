import 'package:dulichquangninh/common/constants/firebase_constants.dart';
import 'package:dulichquangninh/providers/models/diem_du_lich_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class DiemDuLichSource {
  final _databaseReference = FirebaseDatabase.instance
      .reference()
      .child(FirebaseConstants.diemDuLichCollect);

  Future<List<DiemDuLichModel>> getAllDiemDuLich() async {
    List<DiemDuLichModel> list = [];

    try {
      final snapshot = await _databaseReference.once();
      debugPrint('getAllDiemDuLich : ${snapshot.value}');

      if (snapshot.value != null) {
        final listValue = snapshot.value as List;
        listValue.forEach((value) {
          list.add(DiemDuLichModel.fromJson(value));
        });
      }
      return list;
    } catch (e) {
      throw e;
    }
  }
}
