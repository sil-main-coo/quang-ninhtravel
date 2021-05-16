import 'package:equatable/equatable.dart';
import 'contact_model.dart';
import 'location_model.dart';

class ServiceModel extends Equatable {
  String type;
  String typeName;
  String name;
  String address;
  Contact contact;
  LocationModel location;

  ServiceModel({this.type, this.name, this.address, this.location});

  ServiceModel.fromJson(Map json) {
    type = json['type'];
    name = json['name'];
    typeName = json['type-name'];
    address = json['address'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    if (json['location'] != null) {
      location = LocationModel.fromJson(json['location']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['type-name'] = this.typeName;
    data['name'] = this.name;
    data['address'] = this.address;
    data['location'] = this.location.toJson();
    if (this.contact != null) {
      data['contact'] = this.contact.toJson();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [type, typeName, name, address, contact];
}
