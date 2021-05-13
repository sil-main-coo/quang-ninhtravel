import 'dart:convert';

import 'package:dulichquangninh/common/constants/firebase_constants.dart';
import 'package:dulichquangninh/providers/models/loai_di_tich_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class LoaiDiTichSource {
  final _databaseReference = FirebaseDatabase.instance
      .reference()
      .child(FirebaseConstants.loaiDiTichCollect);
  final _refImageStorage =
      FirebaseStorage.instance.ref().child(FirebaseConstants.imagesStorage);

  Future<List<LoaiDiTichModel>> getLoaiDiTichs() async {
    List<LoaiDiTichModel> list = [];

    try {
      final snapshot = await _databaseReference.once();
      debugPrint('getLoaiDiTichs : ${snapshot.value}');
      if (snapshot.value != null) {
        final map = Map<String, dynamic>.from(snapshot.value);
        final keys = map.keys;

        for (var key in keys) {
          final model = LoaiDiTichModel.fromJson(map[key], tag: key);
          model.image = await _getImageURL(model.tag);

          list.add(model);
        }
      }

      return list;
    } catch (e) {
      throw e;
    }
  }

  Future<String> _getImageURL(String tag) async {
    print('/image/$tag/$tag.jpg');
    try {
      var imagesTag = _refImageStorage.child(tag);
      if (imagesTag != null) {
        final image = imagesTag.child('$tag.jpg');
        final url = await image.getDownloadURL();
        debugPrint(url);
        return url;
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
