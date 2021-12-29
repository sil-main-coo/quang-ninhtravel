import 'dart:convert';
import 'dart:typed_data';

class User {
  String phone, password;
  DateTime createAt, updateAt;
  UserProfile profile;

  User(
      {this.password,
      this.phone,
      this.profile,
      DateTime createAt,
      DateTime updateAt}) {
    this.createAt = createAt ?? DateTime.now();
    this.updateAt = updateAt ?? DateTime.now();
  }

  factory User.fromJson(Map<String, dynamic> json, [String id]) {
    return User(
        password: json['password'],
        phone: json['phone'],
        // createAt: json['createAt'] != null
        //     ? DateTime.fromMillisecondsSinceEpoch(json['create-at'])
        //     : null,
        // updateAt: json['updateAt'] != null
        //     ? DateTime.fromMillisecondsSinceEpoch(json['update-at'])
        //     : null,
        profile: json['profile'] != null
            ? UserProfile.fromJson(Map<String, dynamic>.from(json['profile']))
            : null);
  }

  factory User.fromRawData(String jsonString) {
    return User.fromJson(jsonDecode(jsonString));
  }

  String toRawData() {
    return jsonEncode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      'password': this.password,
      'phone': this.phone,
      'create-at': this.createAt?.millisecondsSinceEpoch,
      'update-at': this.updateAt?.millisecondsSinceEpoch,
      'profile': this.profile?.toJson()
    };
  }
}

class UserProfile {
  String id, fullName, avatar, phone, email;

  String getAvatarText() {
    if (fullName == null) return 'N/A';
    final arr = fullName.split(' ');

    return arr.length == 1
        ? arr[0][0]
        : '${arr[0][0]}${arr[arr.length - 1][0]}';
  }

  UserProfile({this.id, this.fullName, this.avatar, this.phone, this.email});

  factory UserProfile.fromJson(Map<String, dynamic> json, [String id]) {
    return UserProfile(
        id: id ?? json['id'],
        fullName: json['full-name'],
        avatar: json['avatar'],
        phone: json['phone'],
        email: json['email']);
  }

  factory UserProfile.fromRawData(String jsonString) {
    return UserProfile.fromJson(jsonDecode(jsonString));
  }

  String toRawData() {
    return jsonEncode(this.toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      'full-name': this.fullName,
      'avatar': this.avatar,
      'id': this.id,
      'phone': this.phone,
      'email': this.email
    };
  }

  @override
  String toString() {
    return this.fullName != null ? '${this.fullName}' : '';
  }
}
