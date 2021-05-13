import 'package:dulichquangninh/providers/data_sources/remote/image_storage_source.dart';
import 'package:flutter/cupertino.dart';

abstract class ImageRepo {
  Future<List<String>> getCoverImages();
}

class ImageRepoImpl implements ImageRepo {
  final ImageStorageSource imageStorageSource;

  ImageRepoImpl({@required this.imageStorageSource});

  @override
  Future<List<String>> getCoverImages() async {
    return await imageStorageSource.getImageURLs('cover');
  }
}
