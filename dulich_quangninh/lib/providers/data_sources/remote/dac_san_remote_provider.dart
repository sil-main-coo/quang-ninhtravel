import 'package:dulichquangninh/common/constants/firebase_constants.dart';
import 'package:dulichquangninh/common/error/remote_exception.dart';
import 'package:dulichquangninh/providers/models/comment.dart';
import 'package:dulichquangninh/providers/models/dac_san_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DacSanSource {
  final _databaseReference = FirebaseDatabase.instance
      .reference()
      .child(FirebaseConstants.dacSansCollect);

  final _refImageStorage =
      FirebaseStorage.instance.ref().child(FirebaseConstants.imagesStorage);
  final _refHtmlStorage =
      FirebaseStorage.instance.ref().child(FirebaseConstants.htmlStorage);

  Stream<Event> streamCommentsWithID(String id) {
    return _databaseReference
        .child(id)
        .child(FirebaseConstants.comments)
        .onValue;
  }

  Future<Comment> addNewCommentToDB(String id, Comment comment) async {
    try {
      final ref =
          _databaseReference.child(id).child(FirebaseConstants.comments);
      final cmtID = ref.push();
      comment.id = cmtID.key;
      await cmtID.set(comment.toJson());
      return comment;
    } on RemoteException catch (e) {
      throw e.toString();
    } catch (e) {
      throw RemoteException('Thêm nhận xét thất bại');
    }
  }

  Future<List<DacSanModel>> getAllDacSan() async {
    List<DacSanModel> list = [];

    try {
      final snapshot = await _databaseReference.once();
      print(snapshot.value);
      if (snapshot.value != null) {
        final map = snapshot.value as Map;
        map.forEach((key, value) async {
          final dacsan = DacSanModel.fromJson(key, value);
          dacsan.images = await _getImageURLs(dacsan.type, dacsan.tag);
          list.add(dacsan);
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
