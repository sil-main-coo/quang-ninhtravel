import 'package:dulichquangninh/common/constants/firebase_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageStorageSource {
  final _ref =
      FirebaseStorage.instance.ref().child(FirebaseConstants.imagesStorage);

  Future<List<String>> getImageURLs(String type, {String tag}) async {
    List<String> urls = [];

    final ref = tag == null ? _ref.child(type) : _ref.child(type).child(tag);

    var images = await ref.listAll();
    if (images.items.isNotEmpty) {
      for (var element in images.items) {
        final url = await element.getDownloadURL();
        urls.add(url);
      }
    }
    return urls;
  }
}
