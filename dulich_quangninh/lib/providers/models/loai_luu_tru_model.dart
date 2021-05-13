import 'package:equatable/equatable.dart';

class LoaiLuuTruModel extends Equatable {
  String name;
  String tag;

  LoaiLuuTruModel.fromJson(var json, {String tag}) {
    if (json is String) {
      this.tag = tag;
      this.name = json;
    } else {
      this.tag = json['tag'];
      this.name = json['name'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['tag'] = this.tag;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [name, tag];
}
