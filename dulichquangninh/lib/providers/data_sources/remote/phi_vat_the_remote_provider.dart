import 'package:dulichquangninh/common/constants/firebase_constants.dart';
import 'package:dulichquangninh/common/error/remote_exception.dart';
import 'package:dulichquangninh/providers/models/dac_san_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/phi_vat_the_model.dart';

class PhiVatTheSource {
  final _databaseReference = FirebaseDatabase.instance
      .ref()
      .child(FirebaseConstants.phiVatThesCollect);

  final _refImageStorage =
      FirebaseStorage.instance.ref().child(FirebaseConstants.imagesStorage);
  final _refHtmlStorage =
      FirebaseStorage.instance.ref().child(FirebaseConstants.htmlStorage);

  Stream<DatabaseEvent> streamCommentsWithID(String id) {
    return _databaseReference
        .child(id)
        .child(FirebaseConstants.comments)
        .onValue;
  }

  Future<List<PhiVatTheModel>> getAllPhiVatThe() async {
    List<PhiVatTheModel> list = [];

    try {
      final snapshot = (await _databaseReference.once()).snapshot;
      if (snapshot.value != null) {
        final map = snapshot.value as Map;
        map.forEach((key, value) async {
          final item = PhiVatTheModel.fromJson(key, value);
          item.images = await _getImageURLs(item.type ?? '', item.tag ?? '');
          list.add(item);
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
