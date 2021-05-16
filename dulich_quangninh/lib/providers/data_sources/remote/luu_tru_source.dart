import 'package:dulichquangninh/common/constants/firebase_constants.dart';
import 'package:dulichquangninh/providers/models/luu_tru_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class LuuTruSource {
  final _databaseReference = FirebaseDatabase.instance
      .reference()
      .child(FirebaseConstants.luuTrusCollect);

  Future<List<LuuTruModel>> getAllLuuTru() async {
    List<LuuTruModel> list = [];

    try {
      final snapshot = await _databaseReference.once();
      debugPrint('getAllLuuTru : ${snapshot.value}');

      if (snapshot.value != null) {
        final map = snapshot.value as Map;
        map.forEach((key, value) {
          list.add(LuuTruModel.fromJson(key, value));
        });
      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  Future<List<LuuTruModel>> getLuuTruByType(String type) async {
    List<LuuTruModel> list = [];
    try {
      final snapshot = await _databaseReference
          .orderByChild(FirebaseConstants.luuTruKey)
          .equalTo(type)
          .once();
      debugPrint('getLuuTruByType : ${snapshot.value}');

      if (snapshot.value != null) {
        if (snapshot.value is List) {
          for (var value in snapshot.value) {
            if (value != null) {
              final mapValue = Map.from(value);
              final diTich = LuuTruModel.fromJson(null, mapValue);
              list.add(diTich);
            }
          }
        } else {
          final map = Map<dynamic, dynamic>.from(snapshot.value);
          for(var entry in map.entries){
            final mapValue = Map.from(entry.value);
            final diTich = LuuTruModel.fromJson(entry.key, mapValue);
            list.add(diTich);
          }
        }
      }
      return list;
    } catch (e) {
      throw e;
    }
  }
}
