import 'package:dulichquangninh/providers/models/comment.dart';
import 'package:dulichquangninh/providers/models/parents/location_model.dart';
import 'package:equatable/equatable.dart';

class DiTichModel extends Equatable {
  String name;
  String id;
  String tag;
  String type;
  String typeName;
  String video;
  String html;
  List<String> images;
  LocationModel location;
  List<Comment> comments;

  DiTichModel(
      {this.name,
      this.tag,
      this.type,
      this.video,
      this.location,
      this.comments});

  DiTichModel.fromJson(String id, Map json) {
    this.id = id;
    name = json['name'];
    tag = json['tag'];
    images = json['images'];
    html = json['html'];
    type = json['type'];
    typeName = json['type-name'];
    images = json['images'];
    video = json['video'];
    if (json['location'] != null) {
      location = LocationModel.fromJson(json['location']);
    }

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
    data['location'] = this.location.toJson();
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [name, tag, typeName, type, video, images];
}
