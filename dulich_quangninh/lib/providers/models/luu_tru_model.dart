import 'package:equatable/equatable.dart';
import 'parents/service_model.dart';

class LuuTruModel extends ServiceModel with EquatableMixin {
  RoomPrice roomPrices;
  String id;

  LuuTruModel.fromJson(var id, Map json)
      : super.fromJson(json) {
    roomPrices =
        json['price'] != null ? new RoomPrice.fromJson(json['price']) : null;
    this.id = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    if (this.roomPrices != null) {
      data['price'] = this.roomPrices.toJson();
      data['id'] = this.id;
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => super.props..add(roomPrices)..add(id);
}

class RoomPrice extends Equatable {
  String singleValue;
  String doubleValue;

  RoomPrice({this.singleValue, this.doubleValue});

  RoomPrice.fromJson(Map json) {
    singleValue = json['single'];
    doubleValue = json['double'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['single'] = this.singleValue;
    data['double'] = this.doubleValue;
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [singleValue, doubleValue];
}
