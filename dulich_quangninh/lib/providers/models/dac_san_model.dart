import 'package:dulichquangninh/providers/models/comment.dart';
import 'package:equatable/equatable.dart';

class DacSanModel extends Equatable {
  String name;
  String id;
  String tag;
  String type;
  String typeName;
  String video;
  String html;
  List<String> images;
  List<Comment> comments;

  DacSanModel(
      {this.name,
        this.tag,
        this.type,
        this.video,
        this.comments});

  DacSanModel.fromJson(String id, Map json) {
    this.id = id;
    name = json['name'];
    tag = json['tag'];
    images = json['images'];
    html = json['html'];
    type = json['type'];
    typeName = json['type-name'];
    images = json['images'];
    video = json['video'];

    if (json['comments'] != null) {
      comments = [];
      (json['comments'] as Map)
          .forEach((id, js) => comments.add(Comment.fromJson(Map.from(js))));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tag'] = this.tag;
    data['html'] = this.html;
    data['type'] = this.type;
    data['type-name'] = this.typeName;
    data['images'] = this.images;
    data['video'] = this.video;
    data['images'] = this.images;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [name, tag, typeName, type, video, images];
}
