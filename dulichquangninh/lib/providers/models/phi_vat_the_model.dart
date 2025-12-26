import 'package:equatable/equatable.dart';

class PhiVatTheModel extends Equatable {
  String? name;
  String? id;
  String? tag;
  String? type;
  String? typeName;
  String? video;
  String? html;
  List<String>? images;

  PhiVatTheModel(
      {this.name,
        this.tag,
        this.type,
        this.video,});

  PhiVatTheModel.fromJson(String id, Map json) {
    this.id = id;
    name = json['name'];
    tag = json['tag'];
    images = json['images'];
    html = json['html'];
    type = json['type'];
    typeName = json['type-name'];
    images = json['images'];
    video = json['video'];
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
  List<Object?> get props => [name, tag, typeName, type, video, images];
}
