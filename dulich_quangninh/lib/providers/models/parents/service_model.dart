
import 'package:equatable/equatable.dart';
import 'contact_model.dart';

class ServiceModel extends Equatable {
  String type;
  String typeName;
  String name;
  String address;
  Contact contact;

  ServiceModel(
      {this.type, this.name, this.address,});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    typeName = json['type-name'];
    address = json['address'];
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['type-name'] = this.typeName;
    data['name'] = this.name;
    data['address'] = this.address;
    if (this.contact != null) {
      data['contact'] = this.contact.toJson();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props =>
      [type, typeName, name, address, contact];
}
