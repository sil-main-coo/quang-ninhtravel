
class Contact {
  String fullName;
  String position;
  List<String> phone;

  Contact({this.fullName, this.position, this.phone});

  Contact.fromJson(Map json) {
    fullName = json['full-name'];
    position = json['position'];
    phone = json['phone'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full-name'] = this.fullName;
    data['position'] = this.position;
    data['phone'] = this.phone;
    return data;
  }
}