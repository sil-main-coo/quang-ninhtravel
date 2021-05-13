import 'package:equatable/equatable.dart';

class LoaiDiTichModel extends Equatable {
  String name;
  String tag;
  String image;

  LoaiDiTichModel.fromJson(var json, {String tag}) {

    if(json is String){
      this.tag = tag;
      this.name = json;
    }else {
      this.tag = json['tag'];
      this.name = json['name'];
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['tag'] = this.tag;
    data['images'] = this.image;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [name, tag, image];
}
