import 'package:dulichquangninh/common/constants/firebase_constants.dart';
import 'package:dulichquangninh/providers/models/di_tich_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class DiTichSource {
  final _databaseReference = FirebaseDatabase.instance
      .reference()
      .child(FirebaseConstants.diTichsCollect);

  final _refImageStorage =
  FirebaseStorage.instance.ref().child(FirebaseConstants.imagesStorage);
  final _refHtmlStorage =
  FirebaseStorage.instance.ref().child(FirebaseConstants.htmlStorage);

  Future<List<DiTichModel>> getAllDiTich() async {
    List<DiTichModel> list = [];

    try {
      final snapshot = await _databaseReference.once();
      debugPrint('getAllDiTich : ${snapshot.value}');

      if (snapshot.value != null) {
        final map = snapshot.value as Map;
        map.forEach((key, value) {
          list.add(DiTichModel.fromJson(key, value));
        });
      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  Future<List<DiTichModel>> getDiTichByType(String type) async {
    List<DiTichModel> list = [];

    try {
      final snapshot = await _databaseReference
          .orderByChild(FirebaseConstants.diTichKey)
          .equalTo(type)
          .once();
      debugPrint(
          'getDiTichByType : ${snapshot.value.length} - ${snapshot.value}');

      if (snapshot.value != null) {
        final map = Map<dynamic, dynamic>.from(snapshot.value);
        map.forEach((key, value) async {
          final diTich = DiTichModel.fromJson(key, value);
          diTich.images = await _getImageURLs(diTich.type, diTich.tag);
          diTich.html = await _getDescriptionURL(diTich.type, diTich.tag);
          list.add(diTich);
        });
      }
      return list;
    } catch (e) {
      throw e;
    }
  }

  Future<List<String>> _getImageURLs(String type, String tag) async {
    List<String> urls = [];

    var images = await _refImageStorage.child(type).child(tag).listAll();
    if (images.items.isNotEmpty) {
      images.items.forEach((element) async {
        final url = await element.getDownloadURL();
        urls.add(url);
      });
    }
    return urls;
  }

  Future<String> _getDescriptionURL(String type, String tag) async {
    var html = _refHtmlStorage.child(type).child('$tag.html');
    final url = await html.getDownloadURL();
    print(url);
    return url;
  }
}
